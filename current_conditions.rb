require 'bundler/setup'
require 'httparty'
require 'pry'

class CurrentConditions

  BASE_URI = "http://api.wunderground.com/api/"
  API_KEY = ENV["WUNDERGROUND_KEY"]

  def get(zip)
      HTTParty.get("#{BASE_URI}#{API_KEY}/conditions/q/#{zip}.json")
  end

  def temp(zip)
    get(zip)["current_observation"]["temp_f"]
  end

  def requested_city(zip)
    get(zip)["current_observation"]["display_location"]["full"]
  end

  def weather(zip)
    get(zip)["current_observation"]["weather"]
  end

end
