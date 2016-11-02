require 'active_record'
require './db_connection'
require './migrations'

class WeatherData < ActiveRecord::Base
  serialize :api_data, Hash
end
