require 'minitest/autorun'
require 'minitest/pride'
require './weather_data'
require 'webmock/minitest'

require 'active_support'
require 'active_support/core_ext'


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

end
