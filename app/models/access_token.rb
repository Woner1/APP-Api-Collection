class AccessToken < ApplicationRecord
  belongs_to :user
  has_secure_token
  has_secure_token :refresh_token

  def exprires_at
    created_at + exprires_in.seconds
  end

  def expired?
    Time.now.utc > exprires_at
  end

end
