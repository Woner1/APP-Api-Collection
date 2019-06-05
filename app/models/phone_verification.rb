class PhoneVerification < ApplicationRecord
  validates :phone_number,presence: true,uniqueness: true,phone: true

  def generate_code
    self.code=rand(000000..999999).to_s.rjust(6,"0")
  end

  def self.check(phone_number,verification_code)
    exists?(phone_number: phone_number,code: verification_code)
  end
end
