require 'bundler/setup'
require 'httparty'
require 'pry'

class CurrentConditions

  BASE_URI = "http://api.wunderground.com/api/"
  API_KEY = ENV["WUNDERGROUND_KEY"]

  def get(zip)
    HTTParty.get("#{BASE_URI}#{API_KEY}/conditions/q/#{zip}")
  end

end
