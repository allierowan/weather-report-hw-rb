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

end
