FactoryBot.define do
  factory :category do
    name { FFaker::Game.category }
  end
end
