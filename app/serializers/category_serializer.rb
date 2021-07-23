class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :series
  has_many :movies
end
