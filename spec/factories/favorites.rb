FactoryBot.define do
  factory :favorite do
    favoritable { nil }
    user
  end
end
