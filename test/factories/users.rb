# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { generate :name }
    last_name { generate :lastname }
    password { generate :password_hash }
    email { generate :email }
    avatar { './test/fixtures/files/avatar.png' }
    type { generate :user_type }
    
    factory :admin do
      type { 'admin' }
    end

    factory :developer do
      type { 'developer' }
    end  

    factory :manager do
      type { 'manager' }
    end

    trait :author do
      type { 'manager' }
    end

    trait :assignee do
      type { 'developer' }
    end
  end
end
