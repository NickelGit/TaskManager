# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    name { generate :task_name }
    description { generate :task_description }
    author factory: :manager
    state { 'new_task' }
    expired_at { DateTime.now + 15 }
    trait :assigned do
      assignee factory: :developer
    end
  end
end
