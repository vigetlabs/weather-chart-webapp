class Setting < ActiveRecord::Base
  belongs_to :data_type

  def self.regenerate
    @settings = Setting.first
    @value_min = 999
    @value_max = -999
    @temp_array = []

    @position = build_position
    @light = build_light
    @settings.update_attributes(:position => @position, :light => @light)
  end

  def self.construct_packet
    settings = Setting.first
    packet = "#{settings.position}"
    #packet += "#{settings.light}"
  end

  private

  def self.scale_position(pos,in_min,in_max,out_min,out_max)
    return ((pos - in_min) * (out_max - out_min) / (in_max - in_min) + out_min).to_i
  end

  def self.build_position
    real_position = ""
    position = ""
    values = {}

    6.times do |i|
      # right now i'm adding an hour. i.e: 1:36PM Get's rounded up to 2:00 PM as the present time. That's because we're not fetching historic data.
      values[i] = DataPoint.where(zipcode: @settings.zipcode).where(data_type: @settings.data_type).where(value_timestamp: Time.now.beginning_of_hour + 1.hour - @settings.now.hours + (i.minutes * (@settings.x_res/6))).take
      values[i] = values[i].value

      if values[i].nil?
        values[i] = rand(20..80)
      end

      # Once we start doing historic data, we'll need to handle the possibility for nil values[i].
      if values[i] < @value_min
        @value_min = values[i]
      end
      if values[i] > @value_max
        @value_max = values[i]
      end
    end

    values.each do |key,val|
      real_position += "#{val},"
      @temp_array << val.to_i
      position += "#{scale_position(val,@value_min,@value_max,90,10)}," #TODO pull scale out into own method
    end

    puts "Real temperatures: #{real_position}"
    puts "Positions for new packet: #{position}"

    return position.chop! #remove trailing comma
  end

  def self.build_light
    light_string = ""

      case @settings.data_type.name
        when "Temperature"
          light_string = @temp_array.to_csv.delete!("\n")
        when "Precipitation"
          light_string = ""
      end
    return light_string
  end

  def self.position_to_array(position)
    position.split(',')
  end

private

  def self.get_light_pos_string(segment)
    case segment
      when 0
        return "0,10"
      when 1
        return "10,30"
      when 2
        return "30,50"
      when 3
        return "50,70"
      when 4
        return "70,90"
      when 5
        return "90,100"
    end
  end

end
