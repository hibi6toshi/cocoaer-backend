FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user_#{n}" }
    sequence(:sub) { |n| "sub_#{n}" }
    avatar { nil }
  end
end
