FactoryBot.define do
  factory :user do
    first_name { generate :name }
    last_name { generate :lastname}
    password { generate :password_hash }
    email { generate :email }
    avatar { "./test/fixtures/files/avatar.png" }
    type { generate :user_type }

    trait :author do
      first_name { generate :name }
      last_name { generate :lastname}
      password { generate :password_hash }
      email { generate :email }
      avatar { "./test/fixtures/files/avatar.png" }
      type { 'manager' }
    end

    trait :assignee do
      first_name { generate :name }
      last_name { generate :lastname}
      password { generate :password_hash }
      email { generate :email }
      avatar { "./test/fixtures/files/avatar.png" }
      type { 'developer' }
    end
  end
end
