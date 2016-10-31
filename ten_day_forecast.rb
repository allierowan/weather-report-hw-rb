require 'bundler/setup'
require 'httparty'
require 'pry'

class TenDayForecast
  BASE_URI = "http://api.wunderground.com/api/"
  API_KEY = ENV["WUNDERGROUND_KEY"]

  def get(zip)
    HTTParty.get("#{BASE_URI}#{API_KEY}/forecast10day/q/#{zip}.json")
  end

  def all_ten_days(zip)
    day_array = get(zip)["forecast"]["txt_forecast"]["forecastday"]
    results_hash = {}
    day_array.each do |day_hash|
      results_hash[day_hash["period"]] = [day_hash["title"], day_hash["fcttext"] ]
    end
    results_hash
  end

  def weather_by_day(zip, day)
    {
      desc: get(zip)["forecast"]["txt_forecast"]["forecastday"][day]["fcttext"],
      time: get(zip)["forecast"]["txt_forecast"]["forecastday"][day]["title"]
    }
  end

end
