FactoryBot.define do
  factory :movie do
    title { FFaker::Book.title }
    description { FFaker::Book.description }
    thumbnail_key { FFaker::Bank.iban }
    video_key { FFaker::Bank.iban }
    episode_number { nil }
    featured_thumbnail_key { FFaker::Bank.iban }
    thumbnail_cover_key { FFaker::Bank.iban }
    highlighted { false }
    serie { nil }
    category

    trait :episode do
      serie
      category { nil }
      episode_number { 1 }
    end
  end
end
