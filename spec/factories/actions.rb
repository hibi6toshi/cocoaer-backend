FactoryBot.define do
  factory :action do
    association :user, factory: :user
    association :project, factory: :project
    name { "MyString" }
  end
end
