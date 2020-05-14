# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    name
    description
    author factory: :manager
    state { 'new_task' }
    expired_at { DateTime.now + 15 }
    trait :assigned do
      assignee factory: :developer
    end
  end
end
