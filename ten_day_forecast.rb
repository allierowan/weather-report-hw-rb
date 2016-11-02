require_relative 'wu_api'

class TenDayForecast < WuAPI

  def feature
    "forecast10day"
  end

  def all_ten_days
    day_array = data["forecast"]["txt_forecast"]["forecastday"]
    day_array.reduce{ |results_hash, in_hash| results_hash.update(in_hash["period"] => [in_hash["title"], in_hash["fcttext"]])}
  end

  def weather_by_day(day)
    {
      description: data["forecast"]["txt_forecast"]["forecastday"][day]["fcttext"],
      time: data["forecast"]["txt_forecast"]["forecastday"][day]["title"]
    }
  end

end
