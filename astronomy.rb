require 'bundler/setup'
require 'httparty'
require 'pry'
require_relative 'wu_api'

class Astronomy < WuAPI

  def feature
    "astronomy"
  end

  def time_of_sunrise
    { hour: data["sun_phase"]["sunrise"]["hour"], minute: data["sun_phase"]["sunrise"]["minute"] }
  end

  def time_of_sunset
    { hour: data["sun_phase"]["sunset"]["hour"], minute: data["sun_phase"]["sunset"]["minute"] }
  end

end
