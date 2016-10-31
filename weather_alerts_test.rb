require 'minitest/autorun'
require 'minitest/pride'
require './weather_alerts'
require 'webmock/minitest'

require 'active_support'
require 'active_support/core_ext'

class WeatherAlertsTest < Minitest::Test

  def stub_redirect
    stub_request(
      :get,
      "http://api.wunderground.com/api/#{ENV["WUNDERGROUND_KEY"]}/alerts/q/59261"
    ).to_return(
      :status => 200,
      :body => File.read("./responses/montana_alerts.json"),
      :headers => { 'Content-Type' => 'application/json' }
    )
  end

  def test_class_exists
    assert WeatherAlerts
  end

  def test_get_alerts
    stub_redirect
    alerts = WeatherAlerts.new.get(59261)
    assert_equal "WND", alerts["alerts"][0]["type"]
  end

  def test_get_array_of_alerts
    stub_redirect
    assert_equal ["Lake Wind Advisory"], WeatherAlerts.new.all_alerts(59261)
  end

end
