class Setting < ActiveRecord::Base
  belongs_to :data_type

  def self.regenerate
    @settings = Setting.first
    @settings.update_attributes(:position => build_position, :light => build_light)
  end

  def self.construct_packet
    settings = Setting.first

    #packet = "#{settings.data_type.identifier}|"
    #packet += "#{settings.now}|"
    packet = "#{settings.position}"
    #packet += "#{settings.light}"
  end

  private

  def self.scale_position(pos,in_min,in_max,out_min,out_max)
    return ((pos - in_min) * (out_max - out_min) / (in_max - in_min) + out_min).to_i
  end

  def self.build_position
    position = ""

    values = {}
    value_min = 999
    value_max = -999

    6.times do |i|
      values[i] = DataPoint.where(data_type: @settings.data_type).where(value_timestamp: Time.now.beginning_of_hour - @settings.now.hours + (i.minutes * (@settings.x_res/6))).take
      #puts values[i].id #for debugging
      if values[i].nil?
        values[i] = rand(20..80)
        value_min = 0
        value_max = 100
      else
        values[i] = values[i].value.to_f
        if values[i] < value_min
          value_min = values[i]
        end
        if values[i] > value_max
          value_max = values[i]
        end
      end
    end
    values.each do |key,val| #build the string
      position += "#{scale_position(val,value_min,value_max,90,10)},"
      #position += "#{val}," #for debugging, also comment out line above
    end

    return position.chop! #remove trailing comma
  end

  def self.get_light_pos_string(segment) #0,1,2,3,4,5
    case segment
    when 0
      "0,5"
    when 1
      "15,25"
    when 2
      "35,45"
    when 3
      "55,65"
    when 4
      "75,85"
    when 5
      "95,100"
    end
  end

  def self.build_light
    light_data_type = DataType.where(name: "Precipitation")

    values = {}
    light = ""

    6.times do |i|
      values[i] = DataPoint.where(data_type: light_data_type).where(value_timestamp: Time.now.beginning_of_hour - @settings.now.hours + (i.minutes * (@settings.x_res/6))).take
      values[i] = 0 if values[i].nil?
    end

    #loop through each, and check to see if it's above a threshold, if it is, set the segmetn/location color
    values.each do |key,val|
      if val.value <= 35
        #light += ""
      elsif val.value <= 67
        light += "#{get_light_pos_string(key)},50,0,0,1,"
      elsif val.value<= 85
        light += "#{get_light_pos_string(key)},50,50,00,1,"
      else
        light += "#{get_light_pos_string(key)},50,50,50,1,"
      end
      light
    end

    light = "0,100,0,0,0,3" if light.empty? #if nothing is going on, do the rainbow

    puts light
    return light.chop!
  end
end
