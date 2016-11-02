require 'minitest/autorun'
require 'minitest/pride'
require './current_conditions'
require 'webmock/minitest'

require 'active_support'
require 'active_support/core_ext'

class CurrentConditionsTest < Minitest::Test

  def test_class_exists
    assert CurrentConditions
  end

  def setup
    stub_request(
      :get,
      "http://api.wunderground.com/api/#{ENV["WUNDERGROUND_KEY"]}/conditions/q/20815.json"
    ).to_return(
      :status => 200,
      :body => File.read("./responses/chevy_chase_conditions.json"),
      :headers => { 'Content-Type' => 'application/json' }
    )
  end

  def test_can_get_current_conditions
    chevy_chase = CurrentConditions.new(20815)
    assert_equal 59.0, chevy_chase.data["current_observation"]["temp_f"]
  end

  def test_get_current_temp
    assert_equal 59.0, CurrentConditions.new(20815).temp
  end

  def test_requested_city
    assert_equal "Chevy Chase, MD", CurrentConditions.new(20815).requested_city
  end

  def test_get_weather_desc
    assert_equal "Clear", CurrentConditions.new(20815).weather
  end

  def test_get_weather_for_city_state
    stub_request(
      :get,
      "http://api.wunderground.com/api/#{ENV["WUNDERGROUND_KEY"]}/conditions/q/MD/Chevy_Chase.json"
    ).to_return(
      :status => 200,
      :body => File.read("./responses/chevy_chase_conditions.json"),
      :headers => { 'Content-Type' => 'application/json' }
    )
    assert_equal "Chevy Chase, MD", CurrentConditions.new("Chevy Chase, MD").requested_city
  end

end
