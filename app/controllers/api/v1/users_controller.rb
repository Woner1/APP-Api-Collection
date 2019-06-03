class Api::V1::UsersController < Api::V1::ApplicationController
    def index
        render json: { status: 200}
    end
end
