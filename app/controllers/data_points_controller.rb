class DataPointsController < ApplicationController
  def act
    ChartControl.act
    render "settings/index"
  end
end
