class WundergroundCaller
  def initialize()
    @w_api = Wunderground.new
  end

  def get_hourly_weather()
    @w_api.hourly_for("Boulder","Colorado")
  end

  def get_temperatures()
    response = JSON.parse(get_hourly_weather.to_json)
    temp = {}
    response['hourly_forecast'].each do |response|
      time = response['FCTTIME']['epoch']
      temperature = response['temp']['english']
      temp[time] = temperature
    end

    ## this is for testing purposes!
    # temperatures = "{'1472824800'=>'74', '1472828400'=>'78', '1472832000'=>'80', '1472835600'=>'81', '1472839200'=>'82', '1472842800'=>'81', '1472846400'=>'80', '1472850000'=>'78', '1472853600'=>'74', '1472857200'=>'72', '1472860800'=>'71', '1472864400'=>'69', '1472868000'=>'68', '1472871600'=>'68', '1472875200'=>'67', '1472878800'=>'66', '1472882400'=>'66', '1472886000'=>'66', '1472889600'=>'65', '1472893200'=>'65', '1472896800'=>'64', '1472900400'=>'65', '1472904000'=>'67', '1472907600'=>'70', '1472911200'=>'73', '1472914800'=>'76', '1472918400'=>'78', '1472922000'=>'78', '1472925600'=>'78', '1472929200'=>'77', '1472932800'=>'75', '1472936400'=>'73', '1472940000'=>'72', '1472943600'=>'71', '1472947200'=>'69', '1472950800'=>'69'}"
    # temp = eval(temperatures)

    return temp
  end

  def get_precipitations()
    puts response = JSON.parse(get_hourly_weather.to_json)
    precip = {}
    response['hourly_forecast'].each do |response|
      time = response['FCTTIME']['epoch']
      precip = response['mslp']['english'] #mslp = POP, Probability of Precipitation, qpf = Quantitative Precipitation Forecast
      temp[time] = temperature
    end
  end
end
