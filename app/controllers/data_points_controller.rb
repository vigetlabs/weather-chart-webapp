class DataPointsController < ApplicationController
  def act
    response_string = ""

    case Setting.first.data_type.name
    when "Temperature"
      @dataType = DataType.where(name: "Temperature").take

      @settings = Setting.first
      @old_packet = construct_packet          #generate old packet from current data
      @temperatures = WundergroundCaller.new.get_temperatures   #fetch new temperatures

      @temperatures.each do |key, value|      #save new temperatures
        oldTemp = DataPoint.where(value_timestamp: format_date(key)).take
        if oldTemp.nil?
          DataPoint.create(:data_type => @dataType, :value_timestamp => format_date(key), :value => value)
        else
          if oldTemp.value != value
            oldTemp.value = value
            oldTemp.save!
          end
        end
      end

      update_settings                          #update settings with new values.
      puts @new_packet = construct_packet           #generate new packet from new values.

      if @old_packet != @new_packet
        client = ParticleCaller.new(ENV["PARTICLE_DEVICE_ID"])
        if client.function("trigger", @new_packet)
          puts response_string = "SUCCESS - MADE PARTICLE CALL"
        else
          puts response_string = "FAILURE - TRIED PARTICLE CALL"
        end
      else
        puts response_string = "DID NOT MAKE PARTICLE CALL"
      end

      #TODO delete old unsued data points

      render json: response_string
    when "Precipitation"
      render json: response_string
    end
  end

  private

  def format_date(epoch)
    Time.at(epoch.to_i).utc.to_datetime
  end

  def construct_packet
    settings = Setting.first
    #packet = "#{settings.data_type.identifier}|"
    #packet += "#{settings.now}|"
    packet = "#{settings.position}"
    #packet += "#{settings.light}"
    #TODO compress packet for particle travel
  end

  def update_settings
    @settings.update_attributes(:position => build_position, :light => build_light)
  end

  def build_position
    position = ""

    values = {}
    value_min = 999
    value_max = -999

    6.times do |i|
      values[i] = DataPoint.where(value_timestamp: Time.now.beginning_of_hour - @settings.now.hours + (i.minutes * (@settings.x_res/6))).take
      if values[i].nil?
        values[i] = rand(20..80)
        value_min = 0
        value_max = 100
      else
        values[i] = values[i].value.to_i
        if values[i] < value_min
          value_min = values[i]
        end
        if values[i] > value_max
          value_max = values[i]
        end
      end
    end

    values.each do |key,val|
      position += "#{scale_position(val,value_min,value_max,90,10)},"
    end

    return position.chop! #remove trailing comma
  end

  def scale_position(pos,in_min,in_max,out_min,out_max)
    return ((pos - in_min) * (out_max - out_min) / (in_max - in_min) + out_min)
  end

  def build_light
    return "20:40:40,40:40:40,40:40:40,40:40:40,40:40:40,40:40:40"
  end
end






# 6.times do |i|
#   #Get correct datapoints. A bit complicated. Start by shifting back from NOW to get data points from the past. Adjusts based on Graph length in minutes.
#   value = DataPoint.where(value_timestamp: Time.now.beginning_of_hour - @settings.now.hours + (i.minutes * (@settings.x_res/6))).take
#   if value.nil?
#     position += "0,"
#   else
#     position += "#{invert_scale_position(value.value.to_i)},"
#   end
#end
