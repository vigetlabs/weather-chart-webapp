class ChartControl
  class << self
    def act
      @old_packet = Setting.construct_packet    # Construct old packet from current data

      case Setting.first.data_type.name
        when "Temperature"
          if !DataPoint.fetch_save_temp.nil?     # Fetch data and save to db
            #DataPoint.fetch_save_precip
            Setting.regenerate                      # Update settings with all the new data just saved to the database
            @new_packet = Setting.construct_packet  # Construct new packet from new data
            position_response = call_particle(:position)

            puts "Old Packet: #{@old_packet}"
            puts "New Packet: #{@new_packet}"
          end
        when "Precipitation"
          if !DataPoint.fetch_save_precip.nil?      # Fetch data and save to db
            Setting.regenerate                      # Update settings with all the new data just saved to the database
            @new_packet = Setting.construct_packet  # Construct new packet from new data
            response = call_particle
          end
        end
    end

    def call_particle(type)
      @settings = Setting.first
        client = ParticleCaller.new(ENV["PARTICLE_DEVICE_ID"])
        if client.function("trigger", @new_packet)
          puts @new_packet
          #client.function("clear", "")
          # if @settings.data_type.name == "Temperature"
          #   client.function("temperature", @settings.light)
          # end
          # parse_light_string(Setting.first.light).each do |effect|
          #   client.function("addEffect", effect.to_csv.chop!)
          # end
          response_string = "SUCCESS - UPDATED WEATHER WALL"
        else
          response_string = "FAILURE - TRIED TO UPDATE WEATHER WALL"
        end

      return response_string
    end

    def parse_light_string(light_string) #return array of strings
      array = light_string.split(",")
      array = array.each_slice(6).to_a
    end
  end
end
