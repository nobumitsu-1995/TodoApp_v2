FactoryBot.define do
  factory :user do
    sequence(:name) { |i| "user#{i}" }
    sequence(:email) { |i| "user#{i}@example.com" }
    sequence(:password) { |i| "#{i}" }
  end
end
