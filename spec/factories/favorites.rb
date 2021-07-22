FactoryBot.define do
  factory :favorite do
    favoritable { association :movie }
    user
  end
end
