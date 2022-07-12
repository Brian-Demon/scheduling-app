class UserSerializer < ActiveModel::Serializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :first_name, :last_name, :title, :role, :provider, :uid

  has_many :shifts
  has_many :exclusions
end
