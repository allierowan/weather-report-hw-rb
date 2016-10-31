require 'minitest/autorun'
require 'minitest/pride'
require './astronomy'
require 'webmock/minitest'

require 'active_support'
require 'active_support/core_ext'

class AstronomyTest < Minitest::Test
  def stub_redirect
    stub_request(
      :get,
      "http://api.wunderground.com/api/#{ENV["WUNDERGROUND_KEY"]}/astronomy/q/20815"
    ).to_return(
      :status => 200,
      :body => File.read("./responses/chevy_chase_astronomy.json"),
      :headers => { 'Content-Type' => 'application/json' }
    )
  end

  def test_class_exists
    assert Astronomy
  end

  def test_get_astronomy
    stub_redirect

    chevy_chase = Astronomy.new.get(20815)
    assert_equal "7", chevy_chase["sun_phase"]["sunrise"]["hour"]
  end

  def test_time_of_sunrise
    stub_redirect
    time_hash = {hour: "7", minute: "35"}
    assert_equal time_hash, Astronomy.new.time_of_sunrise(20815)
  end

  def test_time_of_sunset
    stub_redirect
    time_hash = {hour: "18", minute: "08"}
    assert_equal time_hash, Astronomy.new.time_of_sunset(20815)
  end
end
