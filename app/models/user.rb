class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :trackable, :validatable

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end
