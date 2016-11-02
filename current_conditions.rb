require 'bundler/setup'
require 'httparty'
require 'pry'
require_relative 'wu_api'

class CurrentConditions < WuAPI

  def feature
    "conditions"
  end

  def temp
    data["current_observation"]["temp_f"]
  end

  def requested_city
    data["current_observation"]["display_location"]["full"]
  end

  def weather
    data["current_observation"]["weather"]
  end

end
