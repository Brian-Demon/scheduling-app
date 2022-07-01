class User < ApplicationRecord
  has_secure_password :password, validations: false
  has_many :shifts
  has_many :exclusions

  validates :password, presence: true, :unless => :provider_present?, on: :create
  validates_confirmation_of :password, :unless => :provider_present?, on: :create
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address" }

  def employee_name
    "#{first_name} #{last_name}"
  end

  def self.create_with_omniauth(auth)
    provider = auth["provider"]
    create! do |user|
      user.provider = provider
      user.uid = auth["uid"]
      user.email = auth["info"]["email"]

      case provider
      when "google_oauth2"
        user.first_name = auth["info"]["first_name"]
        user.last_name = auth["info"]["last_name"]
      when "facebook"
        user.first_name = auth["info"]["name"].split(" ").first
        user.last_name = auth["info"]["name"].split(" ").last
      else
      end
    end
  end

  def self.find_or_create_with_omniauth(auth)
    self.find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)
  end

  private

  def provider_present?
    provider.present?
  end
end
