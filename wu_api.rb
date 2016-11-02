require 'bundler/setup'
require 'httparty'
require 'pry'

class WuAPI
  attr_reader :zip, :data

  BASE_URI = "http://api.wunderground.com/api/#{ENV["WUNDERGROUND_KEY"]}"

  def initialize(zip)
    @zip = zip
  end

  def data
    @data ||= HTTParty.get("#{BASE_URI}/#{feature}/q/#{zip}.json")
  end

  def feature
    raise "Subclasses of WuAPI must have a feature method"
  end

end
