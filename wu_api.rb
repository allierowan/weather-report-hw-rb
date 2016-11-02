require 'bundler/setup'
require 'httparty'
require 'pry'

class WuAPI
  attr_reader :zip, :data, :locale
  attr_accessor :locale_endpoint

  BASE_URI = "http://api.wunderground.com/api/#{ENV["WUNDERGROUND_KEY"]}"

  def initialize(locale)
    @locale = locale
    @locale_endpoint = locale
  end

  def locale_endpoint
    if locale.to_s.match(/\A\d{5}/)
      @locale_endpoint = locale
    else
      locale.split(", ")[1] + "/" + locale.split(", ")[0].gsub(" ", "_")
    end
  end

  def data
    @data ||= HTTParty.get("#{BASE_URI}/#{feature}/q/#{locale_endpoint}.json")
  end

  def feature
    raise "Subclasses of WuAPI must have a feature method"
  end

end
