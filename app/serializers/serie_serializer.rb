class SerieSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :thumbnail_key, :featured_thumbnail_key,
    :thumbnail_cover_key, :highlighted

  belongs_to :category
  has_many :episodes
end
