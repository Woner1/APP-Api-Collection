class Api::V1::AccessTokensController < Api::V1::ApplicationController
  skip_before_action :authenticate_user!

  #(wehcat/rerfresh/verification code) login
  def create
    return wechat_login if params[:wechat].present?
    return refresh_token if params[:refresh_token].present?
    return verification_code_login if params[:verification_code].present?
  end

  def verification_code_login
    phone = Phonelib.parse(params[:phone_number])
    verification=PhoneVerification.find_by(phone_number: phone.e164)
    if verification.code ==params[:verification_code]
      user=User.find_by(phone_number: phone.e164)
      if user
        token=AccessToken.create!(user: user,expires_in: 30.days.seconds)
        render_ok token
      else
        render_err 'Dot not yet have an account'
      end
    else
      render_err 'Verification code is incorrect'
    end
  end

  def refresh_token
    access_token = AccessToken.find_by(refresh_token: params[:refresh_token])
    if access_token
      access_token.regenerate_token
      access_token.regenerate_refresh_token
      render_ok  access_token
    else
      unauthenticated!
    end
  end

  def wechat_login
    wechat = params[:wechat]
    user = User.find_by(unionid: wechat[:unionid])
    if user.nil?
      user = User.create!(username: Faker::Name.unique.name, password: Faker::Internet.password(8), nickname: wechat[:nickname],
                          sex: wechat[:sex], province: wechat[:province], country: wechat[:country], headimgurl: wechat[:headimgurl],
                          unionid: wechat[:unionid])
    end
    token = AccessToken.create!(user: user, expires_in: 30.days.seconds)
    render json: {status: 200, data: token}
  end


end
