FactoryBot.define do
  factory :favorite do
    association :user, factory: :user

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
