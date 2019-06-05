class User < ApplicationRecord
    has_secure_password
    validates :phone_number,phone: { allow_blank: true,possible: true },uniqueness: true
end
