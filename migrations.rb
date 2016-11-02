require 'active_record'

class WeatherDataMigration < ActiveRecord::Migration[5.0]
  def change
    create_table :weather_data do |t|
      t.string :locale
      t.string :locale_endpoint
      t.text :data
      t.string :feature
    end
  end
end
