require 'minitest/autorun'
require 'minitest/pride'
require './weather_data'
require 'webmock/minitest'

require 'active_support'
require 'active_support/core_ext'
require 'pry'


class WeatherDataTest < Minitest::Test

  def setup
    ActiveRecord::Migration.verbose = false
    begin
      WeatherDataMigration.migrate(:down)
    rescue
    end
    WeatherDataMigration.migrate(:up)
  end

  def test_class_exists
    assert WeatherData
  end

  def test_can_create_data
    weather = WeatherData.create!(locale: "20815", feature: "this")
    assert_equal weather, WeatherData.first
  end

end
