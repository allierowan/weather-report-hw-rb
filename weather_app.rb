require './astronomy'
require './current_conditions'
require './ten_day_forecast'
require './weather_alerts'

puts "Welcome to this chill weather app. Please enter a 5 digit zip code of the city you would like to know about"
input_zip = gets.chomp.to_i
puts "The weather at that location is:"
puts CurrentConditions.new.weather(input_zip)
