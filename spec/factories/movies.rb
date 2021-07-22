FactoryBot.define do
  factory :movie do
    title { FFaker::Book.title }
    description { FFaker::Book.description }
    thumbnail_key { FFaker::Bank.iban }
    video_key { FFaker::Bank.iban }
    episode_number { 1 }
    featured_thumbnail_key { FFaker::Bank.iban }
    thumbnail_cover_key { FFaker::Bank.iban }
    serie
    category
  end
end
