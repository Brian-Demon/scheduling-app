class User < ApplicationRecord
  has_secure_password :password, validations: false
  has_many :shifts
  has_many :exclusions

  validates :email, presence: true
  validates :provider, presence: true
  validates :uid, presence: true

  def employee_name
    "#{first_name} #{last_name}"
  end

  def self.create_with_omniauth(auth)
    create do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.email = auth["info"]["email"]
      user.first_name = auth["info"]["first_name"]
      user.last_name = auth["info"]["last_name"]
    end
  end

  def self.find_or_create_with_omniauth(auth)
    self.find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)
  end
end
