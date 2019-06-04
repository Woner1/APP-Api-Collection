class Api::V1::ApplicationController < ActionController::API

  include JsonRender
  include ExceptionHandler
  before_action :authenticate_user!

  def authenticate_user!
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)
    unauthenticated! if token.blank?
    token = AccessToken.find_by(token: token)
    if token
      if token.expired?
        expired_token!
      else
        @current_user = token.user
      end
    end
  end

  def current_user
    @current_user
  end

  def current_user?(user)
    user == @current_user
  end

  def unauthenticated!
    response.headers['WWW-Authenticate'] = 'Token realm=Application'
    raise AuthenticationFailed
  end

  def expired_token!
    response.headers['WWW-Authenticate'] = 'Token realm=Application'
    raise TokenExpired
  end

  def unauthorized!
    raise Unauthorized
  end

end
