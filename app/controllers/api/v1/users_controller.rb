class Api::V1::UsersController < Api::V1::ApplicationController
  skip_before_action :authenticate_user!

  def index
    render_ok User.all
  end

  def create
    phone = Phonelib.parse(user_params[:phone_number])
    raise VerificationFailed unless PhoneVerification.check(phone.e164, user_params[:verification_code])
    user = User.create!(username: Faker::Name.unique.name, phone_number: phone.e164, password: Faker::Internet.password(8))
    render_ok user
  end

  private

  def user_params
    params.require(:user).permit(:verification_code, :phone_number)
  end


end
