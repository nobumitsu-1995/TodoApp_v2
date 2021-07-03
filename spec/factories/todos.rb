FactoryBot.define do
  factory :todo do
    sequence(:content) { |i| "Todo#{i}" }
    start_time { rand(1..30).days.from_now }
    deadline_time { rand(1..30).days.from_now }
    status { 0 }
    association :user
  end
end
