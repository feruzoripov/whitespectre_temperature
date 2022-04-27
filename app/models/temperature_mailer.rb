class TemperatureMailer < MandrillMailer::MessageMailer
  default from: 'support@example.com'

  def send_alert(email, temperature)
    email_info = {
      subject: 'Exceed 37.5C',
      to: email,
      text: "Your temperature exceeded 37.5C. Your current temperature is #{temperature}C.",
      html: "<p>Your temperature exceeded 37.5C. Your current temperature is #{temperature}C.</p>",
      view_content_link: true,
      important: true,
      inline_css: true,
    }
    mandrill_mail email_info
  end
end
