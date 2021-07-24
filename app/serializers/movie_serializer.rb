class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :thumbnail_key, :video_key, :featured_thumbnail_key,
    :episode_number, :thumbnail_cover_key, :highlighted

  belongs_to :category

  attribute(:type) { 'movie' }
  attribute(:reviews_count) { object.reviews.count }
  attribute(:thumbnail_url) do
    AWS_BUCKET
      .object("thumbnails/#{object.thumbnail_key}")
      .presigned_url(:get, expires_in: 120)
  end
  attribute(:thumbnail_cover_url) do
    AWS_BUCKET
      .object("thumbnails/#{object.thumbnail_cover_key}")
      .presigned_url(:get, expires_in: 120)
  end
  attribute(:featured_thumbnail_url) do
    AWS_BUCKET
      .object("thumbnails/#{object.featured_thumbnail_key}")
      .presigned_url(:get, expires_in: 120)
  end
  attribute(:video_url) do
    AWS_BUCKET
      .object("videos/#{object.video_key}")
      .presigned_url(:get, expires_in: 120)
  end
end
