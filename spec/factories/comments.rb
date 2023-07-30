FactoryBot.define do
  factory :comment do
    association :user
    sequence(:body) { |n| "comment_body_#{n}" }

    trait :with_article do
      association :commentable, factory: :article
    end

    trait :with_project do
      association :commentable, factory: :project
    end

    trait :with_forum do
      association :commentable, factory: :forum
    end
  end
end
