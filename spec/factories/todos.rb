FactoryBot.define do
  factory :todo do
    content { "MyString" }
    start_time { "2021-06-28 00:48:05" }
    deadline_time { "2021-06-28 00:48:05" }
    end_time { "2021-06-28 00:48:05" }
    status { 1 }
  end
end
