class Api::V1::UsersController < Api::V1::ApplicationController
    skip_before_action :authenticate_user!
    def index
        render json: User.all,status: 200
    end

    def create
        phone=Phonelib.parse(user_params[:phone_number])
        raise VerificationFailed unless PhoneVerification.check(phone.e164,user_params[:verification_code])
        user=User.create!(username: Faker::Name.unique.name,phone_number: phone.e164,password: Faker::Internet.password(8))
        render json: user,status: 200
    end

    private
    def user_params
        params.require(:user).permit(:verification_code,:phone_number)
    end


end
