class User < ApplicationRecord
  has_secure_password
  has_many :shifts
  has_many :exclusions

  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address" }
  validates_uniqueness_of :email
end
