class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :thumbnail_key, :video_key, :featured_thumbnail_key,
    :episode_number, :thumbnail_cover_key, :highlighted

  belongs_to :serie
  belongs_to :category
end
