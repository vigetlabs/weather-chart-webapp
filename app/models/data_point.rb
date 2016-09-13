class DataPoint < ActiveRecord::Base
  belongs_to :data_type

  def self.fetch_save_temp
    temperatures = WundergroundCaller.new.get_temperatures(Setting.first.zipcode)
    submitted = add_to_db(temperatures, DataType.where(name: "Temperature").take, Setting.first.zipcode) if !temperatures.nil?
  end

  def self.fetch_save_precip
    precipitations = WundergroundCaller.new.get_precipitations(Setting.first.zipcode)
    result = add_to_db(precipitations, DataType.where(name: "Precipitation").take, Setting.first.zipcode) if !precipitations.nil?
  end

private

  def self.add_to_db(data, data_type, zipcode)
    @settings = Setting.first

    data.each do |key, value|
      oldData = DataPoint.where(zipcode: @settings.zipcode).where(data_type: @settings.data_type).where(value_timestamp: format_date(key)).take
      if oldData.nil?
        DataPoint.create(:data_type => data_type, :value_timestamp => format_date(key), :value => value, :zipcode => zipcode)
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
