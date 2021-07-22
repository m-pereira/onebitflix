FactoryBot.define do
  factory :review do
    rating { (1..5).to_a.sample }
    description { FFaker::Book.description }
    reviewable { association :movie }
    user
  end
end
