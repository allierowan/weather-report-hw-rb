require 'bundler/setup'
require 'httparty'
require 'pry'
require 'active_support'

class WuAPI
  attr_reader :zip, :locale
  attr_accessor :locale_endpoint, :data

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

    if ::WeatherData.where(locale: locale, feature: feature, created_at: ((Time.now - 3600)..Time.now)).size > 0
      @data = ::WeatherData.find_by(locale: locale, feature: feature).api_data
    else
      @data ||= HTTParty.get("#{BASE_URI}/#{feature}/q/#{locale_endpoint}.json").parsed_response
      ::WeatherData.create!(locale: locale, locale_endpoint: locale_endpoint, feature: feature, api_data: @data)
      return @data
    end

  end

  def feature
    raise "Subclasses of WuAPI must have a feature method"
  end

end
