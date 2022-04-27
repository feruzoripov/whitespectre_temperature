class VerifyAlert
  LIMIT_TEMPERATURE = SystemConfig['limit_temperature'] || 37.5
  EMAIL = 'test@example.com'

  def self.call
    tmp = Temperature.first(5).sum(&:value)
    if  (tmp / 5) > LIMIT_TEMPERATURE.to_f
      TemperatureMailer.send_alert(EMAIL, tmp / 5).deliver_now
    end
  end
end
