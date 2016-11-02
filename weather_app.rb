require './astronomy'
require './current_conditions'
require './ten_day_forecast'
require './weather_alerts'

def cleanup_time(hr, min)
  if hr.to_i > 12
    pm_hr = hr.to_i - 12
    "#{pm_hr}:#{min}pm"
  else
    "#{hr}:#{min}am"
  end
end

def valid_input?(input)
  input.length == 5 && is_numeric?(input) || input.match(/\A[a-zA-Z]+\ ?[a-zA-Z]*\,\ [a-zA-Z]{2}\z/)
end

def is_numeric?(input)
  input.to_i.to_s == input || input.to_f.to_s == input
end

puts "Welcome to this chill weather app. Please enter a 5 digit zip code of the city you would like to know about"
input_zip = gets.chomp
until valid_input?(input_zip)
  puts "You did not input a valid zip code. Please try again"
  input_zip = gets.chomp
end
city = CurrentConditions.new(input_zip).requested_city
weather = CurrentConditions.new(input_zip).weather
temp = CurrentConditions.new(input_zip).temp

sunrise_hr = Astronomy.new(input_zip).time_of_sunrise[:hour]
sunrise_min = Astronomy.new(input_zip).time_of_sunrise[:minute]
sunrise_time = cleanup_time(sunrise_hr, sunrise_min)
sunset_hr = Astronomy.new(input_zip).time_of_sunset[:hour]
sunset_min = Astronomy.new(input_zip).time_of_sunset[:minute]
sunset_time = cleanup_time(sunset_hr, sunset_min)

all_alerts = WeatherAlerts.new(input_zip).all_alerts

puts "#{city}
Weather: It is currently #{temp} degrees fahrenheit and #{weather}."
puts "Today's sunrise is at #{sunrise_time}"
puts "Today's sunset is at #{sunset_time}"
if all_alerts.empty?
  puts "There are no current weather alerts"
else
  puts "The weather alert(s) are: "
  all_alerts.each do |alert|
    puts "#{alert}"
  end
end
puts "The Ten Day Forecast for #{city} is: "
TenDayForecast.new(input_zip).all_ten_days.each do |k,v|
  puts "#{v[0]}: #{v[1]}"
end
