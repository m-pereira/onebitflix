FactoryBot.define do
  factory :player do
    start_date { Time.current }
    end_date { Time.current }
    elapsed_time { Time.current }
    movie
    user
  end
end
