class Api::V1::UsersController < Api::V1::ApplicationController
    def index
        @AccessToken=AccessToken.first
        render json: @AccessToken,serializer: AccessTokenSerializer
    end
end
