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

end
