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

    chevy_chase = TenDayForecast.new(20815)
    assert_equal "Sun and clouds mixed. High 58F. Winds N at 5 to 10 mph.", chevy_chase.data["forecast"]["txt_forecast"]["forecastday"].first["fcttext"]
  end

  def test_get_weather_by_day
    stub_redirect
    array = {description: "Cloudy. High near 60F. Winds SSE at 5 to 10 mph.", time: "Tuesday"}
    assert_equal array, TenDayForecast.new(20815).weather_by_day(2)
  end

  def test_get_weather_all_days
    stub_redirect
    assert_equal "Cloudy. High near 60F. Winds SSE at 5 to 10 mph.", TenDayForecast.new(20815).all_ten_days[2][1]
    # p TenDayForecast.new.all_ten_days(20815)
  end

end
