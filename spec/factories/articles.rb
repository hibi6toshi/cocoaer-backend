FactoryBot.define do
  factory :article do
    association :user, factory: :user
    association :piety_target, factory: :piety_target
    association :piety_category, factory: :piety_category
    sequence(:days) { |n| n }
    sequence(:cost) { |n| 1000 * n }
    sequence(:title) { |n| "article_title_#{n}"}
    sequence(:body) { |n| "article_body_#{n}"}
  end
end
