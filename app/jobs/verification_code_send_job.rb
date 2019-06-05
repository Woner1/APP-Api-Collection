class VerificationCodeSendJob < ApplicationJob
  require 'net/http'
  require 'uri'
  queue_as :default

  def perform(verification)
    send_sms_yunpian(verification.phone_number, " 这里是 ANKH 您的验证码是 #{verification.code}")
    verification.touch(:sent_at)
  end

  def send_sms_yunpian(number, text)
    send_sms_uri = URI.parse('https://sms.yunpian.com/v2/sms/single_send.json')
    params = {apikey: Rails.application.config.app[:sms][:apikey], mobile: number, text: text}
    response = Net::HTTP.post_form(send_sms_uri, params)
    Rails.logger.info response.body
  end

end
