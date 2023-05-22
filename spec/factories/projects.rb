FactoryBot.define do
  factory :project do
    association :user, factory: :user
    association :piety_target, factory: :piety_target
    association :piety_category, factory: :piety_category
    limit_day { Date.new(2023, 12, 31) }
    sequence(:cost) { |n| 1000 * n }
    sequence(:title) { |n| "project_title#{n}" }
    sequence(:body) { |n| "project_body#{n}" }
  end
end
