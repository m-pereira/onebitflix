class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :series
  has_many :movies
end
