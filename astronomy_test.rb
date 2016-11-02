require 'minitest/autorun'
require 'minitest/pride'
require './astronomy'
require 'webmock/minitest'

require 'active_support'
require 'active_support/core_ext'
require './weather_data'


class AstronomyTest < Minitest::Test

  ActiveRecord::Migration.verbose = false
  begin
    WeatherDataMigration.migrate(:down)
  rescue
  end
  WeatherDataMigration.migrate(:up)

  def setup
    stub_request(
      :get,
      "http://api.wunderground.com/api/#{ENV["WUNDERGROUND_KEY"]}/astronomy/q/20815.json"
    ).to_return(
      :status => 200,
      :body => File.read("./responses/chevy_chase_astronomy.json"),
      :headers => { 'Content-Type' => 'application/json' }
    )
    WeatherData.delete_all
  end

  def test_class_exists
    assert Astronomy
  end

  def test_get_astronomy
    chevy_chase = Astronomy.new("20815")
    assert_equal "7", chevy_chase.data["sun_phase"]["sunrise"]["hour"]
  end

  def test_time_of_sunrise
    time_hash = {hour: "7", minute: "35"}
    assert_equal time_hash, Astronomy.new("20815").time_of_sunrise
  end

  def test_time_of_sunset
    time_hash = {hour: "18", minute: "08"}
    assert_equal time_hash, Astronomy.new("20815").time_of_sunset
  end

  def test_getting_new_data_for_zip_adds_to_db
    Astronomy.new("20815").data
    assert ::WeatherData.find_by(locale: "20815", feature: "astronomy")
  end
end
