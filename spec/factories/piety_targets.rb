FactoryBot.define do
  factory :piety_target do
    sequence(:name) { |n| "target_#{n}" }
  end
end
