require 'minitest/autorun'
require 'minitest/pride'
require './ten_day_forecast'
require 'webmock/minitest'

require 'active_support'
require 'active_support/core_ext'

class TenDayForecastTest < Minitest::Test

  def stub_redirect
    stub_request(
      :get,
      "http://api.wunderground.com/api/#{ENV["WUNDERGROUND_KEY"]}/forecast10day/q/20815.json"
    ).to_return(
      :status => 200,
      :body => File.read("./responses/chevy_chase_10day.json"),
      :headers => { 'Content-Type' => 'application/json' }
    )
  end

  def test_class_exists
    assert TenDayForecast
  end

  def test_get_ten_day_forecast
    stub_redirect

    chevy_chase = TenDayForecast.new.get(20815)
    assert_equal "Sun and clouds mixed. High 58F. Winds N at 5 to 10 mph.", chevy_chase["forecast"]["txt_forecast"]["forecastday"].first["fcttext"]
  end

  def test_get_weather_by_day
    stub_redirect
    array = {desc: "Cloudy. High near 60F. Winds SSE at 5 to 10 mph.", time: "Tuesday"}
    assert_equal array, TenDayForecast.new.weather_by_day(20815, 2)
  end

end
