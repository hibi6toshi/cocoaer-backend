FactoryBot.define do
  factory :task do
    user { nil }
    project { nil }
    name { "MyString" }
  end
end
