class Api::V1::UsersController < Api::V1::ApplicationController
    def index
        # @AccessToken=AccessToken.first
        # render json: @AccessToken,serializer: AccessTokenSerializer
        chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
        username=chars.shuffle[0..12].join
    end
end
