class TokenExpired < StandardError
  def http_status
    :unauthorized
  end

  def code
    'token_expired'
  end

  def message
    'The access token expired'
  end

  def to_hash
    {
        message: message,
        code: code
    }
  end
end