require 'active_record'
require './db_connection'

class WeatherDataMigration < ActiveRecord::Migration[5.0]
  def change
    create_table :weather_data do |t|
      t.string :locale
      t.string :locale_endpoint
      t.text :api_data
      t.string :feature
      t.datetime :created_at
    end
  end
end
