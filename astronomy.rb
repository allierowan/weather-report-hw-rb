require 'bundler/setup'
require 'httparty'
require 'pry'

class Astronomy
  BASE_URI = "http://api.wunderground.com/api/"
  API_KEY = ENV["WUNDERGROUND_KEY"]

  def get(zip)
    HTTParty.get("#{BASE_URI}#{API_KEY}/astronomy/q/#{zip}")
  end

  def time_of_sunrise(zip)
    { hour: get(zip)["sun_phase"]["sunrise"]["hour"], minute: get(zip)["sun_phase"]["sunrise"]["minute"] }
  end

  def time_of_sunset(zip)
    { hour: get(zip)["sun_phase"]["sunset"]["hour"], minute: get(zip)["sun_phase"]["sunset"]["minute"] }
  end

end
