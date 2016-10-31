require 'bundler/setup'
require 'httparty'
require 'pry'

class TenDayForecast
  BASE_URI = "http://api.wunderground.com/api/"
  API_KEY = ENV["WUNDERGROUND_KEY"]

  def get(zip)
    HTTParty.get("#{BASE_URI}#{API_KEY}/forecast10day/q/#{zip}")
  end

  def weather_by_day(zip, day)
    get(zip)["forecast"]["txt_forecast"]["forecastday"][day]["fcttext"]
  end

end
