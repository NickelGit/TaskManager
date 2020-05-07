# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    name { generate :task_name }
    description { generate :task_description }
    association :author, factory: [:user, :author]    
    state { 'new_task' }
    expired_at { DateTime.now + 15 }

    trait :assigned do
      association :assignee, factory: [:user, :assignee]
    end
  end
end
