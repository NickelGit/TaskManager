FactoryBot.define do
    def setup
        @names = CSV.readlines('./test/fixtures/names.csv', headers: true)
    end

    sequence :email do |n|
        "user#{n}@domain.com"
    end

    sequence(:name, 0..600) do |n|
        @names['name'][n]
    end

    sequence(:lastname, 0..600) do |n|
        @names['name'][n] + 'son'
    end
    
    sequence(:task_name) do |n|
        "Example task name no.#{n}"
    end

    sequence(:task_description) do |n|
        "Example #{n} description \nSecond line of discription \nThird line of description "
    end

    sequence(:user_type, 0..2) do |n|
        user_types = ['admin', 'manager', 'developer']
        user_types[n]
    end

    sequence(:password_hash) do |n|
        "pass#{n}hash"
    end
end