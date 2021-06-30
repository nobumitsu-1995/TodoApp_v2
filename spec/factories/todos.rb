FactoryBot.define do
  factory :todo do
    association :user
    sequence(:content) { |i| "Todo#{i}" }
    start_time { rand(1..30).days.from_now }
    deadline_time { rand(1..30).days.from_now }
    status { 0 }
  end
end
