class DataPointsController < ApplicationController
  def act
    @old_packet = Setting.construct_packet    # Construct old packet from current data

    case Setting.first.data_type.name
    when "Temperature"
      DataPoint.fetch_save_temp               # Fetch data and save to db
      Setting.regenerate                      # Update settings with all the new data just saved to the database
      @new_packet = Setting.construct_packet  # Construct new packet from new data
      render json: call_particle
    when "Precipitation"
      DataPoint.fetch_save_precip             # Fetch data and save to db
      Setting.regenerate                      # Update settings with all the new data just saved to the database
      @new_packet = Setting.construct_packet  # Construct new packet from new data
      render json: call_particle
    end
  end

  def call_particle
    if @old_packet != @new_packet             # Compare packets to see if something needs changed
      client = ParticleCaller.new(ENV["PARTICLE_DEVICE_ID"])
      if client.function("trigger", @new_packet)
        puts response_string = "SUCCESS - MADE PARTICLE CALL"
      else
        puts response_string = "FAILURE - TRIED PARTICLE CALL"
      end
    else
      puts response_string = "DID NOT MAKE PARTICLE CALL (SETTINGS HAVE NOT CHANGED)"
    end
  end
end
