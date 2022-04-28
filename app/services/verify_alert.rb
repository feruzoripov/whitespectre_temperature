class VerifyAlert
  LIMIT_TEMPERATURE = (SystemConfig['limit_temperature'] || 37.5).to_f
  EMAIL = 'test@example.com'

  def self.call
    tmp = Temperature.first(5).sum(&:value) / 5 # trending temperature
    if  tmp > LIMIT_TEMPERATURE
      TemperatureMailer.send_alert(EMAIL, tmp).deliver_now
    end
  end
end
