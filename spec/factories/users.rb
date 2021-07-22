FactoryBot.define do
  factory :user do
    name { FFaker::Name.name }
    email { FFaker::Internet.disposable_email }
    password { FFaker::Internet.password }
  end
end
