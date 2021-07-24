class SerieSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :thumbnail_key, :featured_thumbnail_key,
    :thumbnail_cover_key, :highlighted

  belongs_to :category
  has_many :episodes

  attribute(:thumbnail_url) do
    AWS_BUCKET.object("thumbnails/#{object.thumbnail_key}")
      .presigned_url(:get, expires_in: 120)
  end
  attribute(:thumbnail_cover_url) do
    AWS_BUCKET.object("thumbnails/#{object.thumbnail_cover_key}")
      .presigned_url(:get, expires_in: 120)
  end
  attribute(:featured_thumbnail_url) do
    AWS_BUCKET.object("thumbnails/#{object.featured_thumbnail_key}")
      .presigned_url(:get, expires_in: 120)
  end
end
