class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :registerable, :database_authenticatable, :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :notices
  has_one_attached :avatar

  validates :name, :email, :password, presence: true
end
