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

  def test_get_ten_day_forecast
    stub_request(
      :get,
      "http://api.wunderground.com/api/#{ENV["WUNDERGROUND_KEY"]}/forecast10day/q/20815"
    ).to_return(
      :status => 200,
      :body => File.read("./responses/chevy_chase_10day.json"),
      :headers => { 'Content-Type' => 'application/json' }
    )

    chevy_chase = TenDayForecast.new.get(20815)
    assert_equal "Sun and clouds mixed. High 58F. Winds N at 5 to 10 mph.", chevy_chase["forecast"]["txt_forecast"]["forecastday"].first["fcttext"]
  end

end
