FactoryBot.define do
  factory :piety_category do
    sequence(:name) { |n| "category_#{n}" }
  end
end
