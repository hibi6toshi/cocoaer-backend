FactoryBot.define do
  factory :favorite do
    association :user
    created_at { Time.now }
    updated_at { Time.now }

    trait :with_article do
      association :favoritable, factory: :article
    end

    trait :with_project do
      association :favoritable, factory: :project
    end

    trait :with_forum do
      association :favoritable, factory: :forum
    end
  end
end
