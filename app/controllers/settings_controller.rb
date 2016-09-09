class SettingsController < ApplicationController
  def index
  end

  def type
    data_type = DataType.find(params[:data_type])
    Setting.first.update_attributes(:data_type => data_type)
    flash.now[:success] = "Updated Type: #{data_type.name}"
    render :index
  end

  def resolution
    Setting.first.update_attributes(:x_res => params[:x_res])
    flash.now[:success] = "Updated Resolution: #{params[:x_res]}"
    render :index
  end

  def now
    Setting.first.update_attributes(:now => params[:now])
    flash.now[:success] = "Updated Resolution: #{params[:now]}"
    render :index
  end

  def rainbow
    flash.now[:success] = "RAINBOW!!!"
    render :index
  end

  def worm
    flash.now[:success] = "DO THE WORM!!!"
    render :index
  end

  def zipcode
    Setting.first.update_attributes(:zipcode => params[:setting][:zipcode])
    @new_packet = Setting.construct_packet
    response = call_particle
    flash.now[:success] = "Updated Zipcode: #{params[:setting][:zipcode]}"
    render :index
  end

  def light
    Setting.first.update_attributes(:light => params[:setting][:light])
    @new_packet = Setting.construct_packet
    response = call_particle
    flash.now[:success] = "Updated Light: #{params[:setting][:light]}"
    render :index
  end

  def call_particle
      client = ParticleCaller.new(ENV["PARTICLE_DEVICE_ID"])
      if client.function("trigger", @new_packet)
        puts response_string = "SUCCESS - MADE PARTICLE CALL"
      else
        puts response_string = "FAILURE - TRIED PARTICLE CALL"
      end
    end
end
