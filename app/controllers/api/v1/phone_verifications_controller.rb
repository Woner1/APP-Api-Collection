class Api::V1::PhoneVerificationsController < Api::V1::ApplicationController

  def create
    phone=Phonelib.parse(params[:phone_number])
    verification=PhoneVerification.find_or_create_by(phone_number: phone.e164)
    verification.generate_code
    verification.save!

  end
end
