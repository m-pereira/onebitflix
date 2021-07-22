class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :reviewable, :reviewable_type, :description, :rating

  belongs_to :user
end
