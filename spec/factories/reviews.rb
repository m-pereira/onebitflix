FactoryBot.define do
  factory :review do
    rating { (1..5).to_a.sample }
    description { FFaker::Book.description }
    reviewable { nil }
    user
  end
end
