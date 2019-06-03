class AccessTokenSerializer < ActiveModel::Serializer
  attributes :id,:token,:refresh_token
  belongs_to :user,serializer: UserSerializer
end
