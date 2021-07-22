class FavoriteSerializer < ActiveModel::Serializer
  attributes :id, :favoritable, :favoritable_type

  belongs_to :user
end
