class FavoriteSerializer < ActiveModel::Serializer
  attributes :id, :favoritable_type

  attribute(:favoritable_id) { object.favoritable.id }
  attribute(:title) { object.favoritable.title }
  attribute(:description) { object.favoritable.description }
  attribute(:thumbnail_url) { "/thumbnails/#{object.favoritable.thumbnail_key}" }

  # belongs_to :user
end
