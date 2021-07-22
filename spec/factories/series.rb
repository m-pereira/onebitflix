FactoryBot.define do
  factory :serie do
    title { FFaker::Book.title }
    description { FFaker::Book.description }
    thumbnail_key { FFaker::Bank.iban }
    featured_thumbnail_key { FFaker::Bank.iban }
    thumbnail_cover_key { FFaker::Bank.iban }
    category
  end
end
