class VerificationCodeSendJob < ApplicationJob
  queue_as :default

  def perform(verification)
    send_sms_yunpian(verification.phone_number,text: "【ANKH】您的验证码是 #{verification.code}")
    verification.touch(:sent_at)
  end

  def send_sms_yunpian(number,text)
    send_sms_uri=URI.parse('https://sms.yunpian.com/v1/sms/send.json')
    params={ apikey: "asda",mobile: number,text: text}
    response = Net::HTTP.post_form(send_sms_uri,params)
    Rails.logger.info response.body
  end

end
