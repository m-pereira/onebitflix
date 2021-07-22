FactoryBot.define do
  factory :review do
    rating { 1 }
    description { "MyText" }
    reviewable { nil }
    user { nil }
  end
end
