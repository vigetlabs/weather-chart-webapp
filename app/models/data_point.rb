class DataPoint < ActiveRecord::Base
  belongs_to :data_type

  # @temperatures = WundergroundCaller.new.get_temperatures   #fetch new temperatures
  # @precipitations = WundergroundCaller.new.get_precipitations

  def self.fetch_save_temp
    @temperatures = WundergroundCaller.new.get_temperatures(Setting.first.zipcode)  #fetch temps
    add_to_db(@temperatures, DataType.where(name: "Temperature").take)
  end

  def self.fetch_save_precip
    @precipitations = WundergroundCaller.new.get_precipitations  #fetch temps
    add_to_db(@precipitations, DataType.where(name: "Precipitation").take)
  end

  private

  def self.add_to_db(data, data_type)
    @settings = Setting.first

    data.each do |key, value|      #save new temperatures
      oldData = DataPoint.where(data_type: @settings.data_type).where(value_timestamp: format_date(key)).take
      if oldData.nil?
        DataPoint.create(:data_type => data_type, :value_timestamp => format_date(key), :value => value)
      else
        if oldData.value != value
          oldData.value = value
          oldData.save!
        end
      end
    end
  end

  def self.format_date(epoch)
    Time.at(epoch.to_i).utc.to_datetime
  end

end
