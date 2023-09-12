FactoryBot.define do
  factory :task do
    association :user, factory: :user
    association :project, factory: :project
    name { "MyString" }
  end
end
