FactoryBot.define do
  factory :movie do
    title { "MyString" }
    description { "MyText" }
    thumbnail_key { "MyString" }
    video_key { "MyString" }
    episode_number { 1 }
    featured_thumbnail_key { "MyString" }
    serie { nil }
    category { nil }
    thumbnail_cover_key { "MyString" }
  end
end
