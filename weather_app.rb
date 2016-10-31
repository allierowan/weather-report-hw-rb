require './astronomy'
require './current_conditions'
require './ten_day_forecast'
require './weather_alerts'

def cleanup_time(hr, min)
  if hr.to_i > 12
    pm_hr = hr.to_i - 12
    "#{pm_hr}:#{min}"
  else
    "#{hr}:#{min}"
  end
end
puts "Welcome to this chill weather app. Please enter a 5 digit zip code of the city you would like to know about"
input_zip = gets.chomp.to_i
city = CurrentConditions.new.requested_city(input_zip)
weather = CurrentConditions.new.weather(input_zip)
temp = CurrentConditions.new.temp(input_zip)

sunrise_hr = Astronomy.new.time_of_sunrise(input_zip)[:hour]
sunrise_min = Astronomy.new.time_of_sunrise(input_zip)[:minute]
sunrise_time = cleanup_time(sunrise_hr, sunrise_min)
sunset_hr = Astronomy.new.time_of_sunset(input_zip)[:hour]
sunset_min = Astronomy.new.time_of_sunset(input_zip)[:minute]
sunset_time = cleanup_time(sunset_hr, sunset_min)

all_alerts = WeatherAlerts.new.all_alerts(input_zip)

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
(0..19).to_a.each do |day|
  puts TenDayForecast.new.weather_by_day(input_zip, day)[:time] + ": " + TenDayForecast.new.weather_by_day(input_zip, day)[:desc]
end
