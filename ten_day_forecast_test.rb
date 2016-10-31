require 'minitest/autorun'
require 'minitest/pride'
require './ten_day_forecast'
require 'webmock/minitest'

require 'active_support'
require 'active_support/core_ext'

class TenDayForecastTest < Minitest::Test

  def test_class_exists
    assert TenDayForecast
  end
end
