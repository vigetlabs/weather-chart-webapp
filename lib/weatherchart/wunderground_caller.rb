class WundergroundCaller
  def initialize()
    @w_api = Wunderground.new
  end

  def get_hourly_weather(zipcode)
    zipcode = "80302" if zipcode.empty?
    @w_api.hourly_for("#{zipcode}") #comment this out to save API call
  end

  def get_temperatures(zipcode)
    response = JSON.parse(get_hourly_weather(zipcode).to_json)
    temp = {}
    response['hourly_forecast'].each do |response|
      time = response['FCTTIME']['epoch']
      temp[time] = response['temp']['english']
    end

    ## this is for testing purposes!
    # temperatures = "{'1472824800'=>'74', '1472828400'=>'78', '1472832000'=>'80', '1472835600'=>'81', '1472839200'=>'82', '1472842800'=>'81', '1472846400'=>'80', '1472850000'=>'78', '1472853600'=>'74', '1472857200'=>'72', '1472860800'=>'71', '1472864400'=>'69', '1472868000'=>'68', '1472871600'=>'68', '1472875200'=>'67', '1472878800'=>'66', '1472882400'=>'66', '1472886000'=>'66', '1472889600'=>'65', '1472893200'=>'65', '1472896800'=>'64', '1472900400'=>'65', '1472904000'=>'67', '1472907600'=>'70', '1472911200'=>'73', '1472914800'=>'76', '1472918400'=>'78', '1472922000'=>'78', '1472925600'=>'78', '1472929200'=>'77', '1472932800'=>'75', '1472936400'=>'73', '1472940000'=>'72', '1472943600'=>'71', '1472947200'=>'69', '1472950800'=>'69'}"
    # temp = eval(temperatures)

    return temp
  end

  def get_precipitations()
    response = JSON.parse(get_hourly_weather.to_json)
    precip = {}
    response['hourly_forecast'].each do |response|
      time = response['FCTTIME']['epoch']
      precip[time] = response['mslp']['english'] #mslp = POP, Probability of Precipitation, qpf = Quantitative Precipitation Forecast
    end

    ## this is for testing purposes!
    # precipitations = "{'1473372000'=>'30.07', '1473375600'=>'30.08', '1473379200'=>'30.09', '1473382800'=>'30.09', '1473386400'=>'30.09', '1473390000'=>'30.09', '1473393600'=>'30.09', '1473397200'=>'30.09', '1473400800'=>'30.08', '1473404400'=>'30.08', '1473408000'=>'30.09', '1473411600'=>'30.11', '1473415200'=>'30.12', '1473418800'=>'30.14', '1473422400'=>'30.16', '1473426000'=>'30.16', '1473429600'=>'30.16', '1473433200'=>'30.15', '1473436800'=>'30.12', '1473440400'=>'30.09', '1473444000'=>'30.07', '1473447600'=>'30.06', '1473451200'=>'30.05', '1473454800'=>'30.06', '1473458400'=>'30.07', '1473462000'=>'30.09', '1473465600'=>'30.11', '1473469200'=>'30.12', '1473472800'=>'30.12', '1473476400'=>'30.13', '1473480000'=>'30.13', '1473483600'=>'30.12', '1473487200'=>'30.11', '1473490800'=>'30.12', '1473494400'=>'30.13', '1473498000'=>'30.14'}"
    # precip = eval(precipitations) # convert json into hash
    # #puts precip

    return precip
  end
end
