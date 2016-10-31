require 'bundler/setup'
require 'httparty'
require 'pry'

class WeatherAlerts
  BASE_URI = "http://api.wunderground.com/api/"
  API_KEY = ENV["WUNDERGROUND_KEY"]

  def get(zip)
    HTTParty.get("#{BASE_URI}#{API_KEY}/alerts/q/#{zip}")
  end

  def all_alerts(zip)
    all_alerts = []
    get(zip)["alerts"].each do |alert|
      all_alerts << alert["description"]
    end
    all_alerts
  end
end
