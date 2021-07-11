FactoryBot.define do
  factory :todo do
    sequence(:content) { |i| "Todo#{i}" }
    start_time { rand(1..30).days.from_now }
    deadline_time { rand(1..30).days.from_now }
    status { 0 }
    association :user

    trait :completed do
      status { 1 }
    end

    trait :no_deadline do
      deadline_time { nil }
    end

    trait :overdue_deadline do
      deadline_time { Time.zone.now - rand(1..30).days }
    end
  end
end
