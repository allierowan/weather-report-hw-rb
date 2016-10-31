require 'bundler/setup'
require 'httparty'
require 'pry'

class CurrentConditions

  BASE_URI = "http://api.wunderground.com/api/"
  API_KEY = ENV["WUNDERGROUND_KEY"]

  def get(zip)
    HTTParty.get("#{BASE_URI}#{API_KEY}/conditions/q/#{zip}")
  end

  def temp(zip)
    cond_json = HTTParty.get("#{BASE_URI}#{API_KEY}/conditions/q/#{zip}")
    cond_json["current_observation"]["temp_f"]
  end

  def requested_city(zip)
    cond_json = HTTParty.get("#{BASE_URI}#{API_KEY}/conditions/q/#{zip}")
    cond_json["current_observation"]["display_location"]["full"]
  end

  def weather(zip)
    cond_json = HTTParty.get("#{BASE_URI}#{API_KEY}/conditions/q/#{zip}")
    cond_json["current_observation"]["weather"]
  end

end
