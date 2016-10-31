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

  def test_can_get_current_conditions
    stub_request(
      :get,
      "http://api.wunderground.com/api/#{ENV["WUNDERGROUND_KEY"]}/conditions/q/20815"
    ).to_return(
      :status => 200,
      :body => File.read("./responses/chevy_chase_conditions.json"),
      :headers => {}
    )

    chevy_chase = CurrentConditions.new.get(20815)
    assert_equal 59.0, chevy_chase["temp_f"]

  end

end
