# Weather Report Homework
This app allows a user to input a zip code, and then it goes and gets a variety of information from the Weather Underground API and displays it to the user.

## CurrentConditions
This class handles API requests to wunderground to get current weather conditions.
```ruby
CurrentConditions.new.get(zip) #=> returns the full json
CurrentConditions.new.weather(zip) #=> returns a string describing the weather right now
CurrentConditions.new.temp(zip) #=> returns the current temperature in fahrenheit
CurrentConditions.new.requested_city(zip) #=> returns the name and state of the city requested
```

## TenDayForecast
This class handles API requests to wunderground to get the 10 day forecast.
```ruby
TenDayForecast.new.get(zip) #=> returns the full json of 10 day forecast API call
TenDayForecast.new.all_ten_days(zip) #=> returns a hash with weather info from all 10 days and nights. The format is {0 => ["Monday", "Weather is clear"], 1 => ["Monday Night", "Weather is cloudy"],...}

```

## Astronomy
This class handles API requests to wunderground to get the astronomy info, including sunrise and sunset times.
```ruby
Astronomy.new.get(zip) #=> returns the full json of Astronomy API call
Astronomy.new.time_of_sunrise(zip) #=> returns a hash with the hour and minute of the sunrise for this zip, i.e. {hour: 7, minute: 35}
Astronomy.new.time_of_sunset(zip) #=> returns a hash with the hour and minute of the sunrise for this zip, i.e. {hour: 18, minute: 30}
```

## WeatherAlerts
This class handles API requests to wunderground to get the weather alerts, if there are any.
```ruby
WeatherAlerts.new.get(zip) #=> returns the full json of alerts API call
WeatherAlerts.new.all_alerts(zip) #=> returns an array with all the alerts of the given zip
```
