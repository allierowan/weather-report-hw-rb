require_relative 'wu_api'

class WeatherAlerts < WuAPI

  def feature
    "alerts"
  end

  def all_alerts
    all_alerts = []
    data["alerts"].each do |alert|
      all_alerts << alert["description"]
    end
    all_alerts
  end
end
