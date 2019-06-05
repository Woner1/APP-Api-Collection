class Api::V1::AccessTokensController < Api::V1::ApplicationController
    skip_before_action :authenticate_user!

    def create
        return wechat_login if params[:wechat].present?
        return refresh_token if params[:refresh_token].present?
    end

    def verification_code_login
        phone=Phonelib.parse(params[:phone_number])
       
    end

    def refresh_token
        access_token=AccessToken.find_by(refresh_token: params[:refresh_token])
        if access_token
            access_token.regenerate_token
            access_token.regenerate_refresh_token
            render json: access_token,status: 200
        else
            unauthenticated!
        end
    end

    def wechat_login
        wechat=params[:wechat]
        user=User.find_by(unionid: wechat[:unionid])
        if user.nil?
            user=User.create!(username: Faker::Name.unique.name,password: Faker::Internet.password(8),nickname: wechat[:nickname],
                              sex: wechat[:sex],province: wechat[:province],country: wechat[:country],headimgurl: wechat[:headimgurl],
                              unionid: wechat[:unionid])
        end
        token = AccessToken.create!(user: user,expires_in: 30.days.seconds)
        render json: { status:200,data: token }
    end


end
