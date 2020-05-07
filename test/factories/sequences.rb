# frozen_string_literal: true

require 'csv'

FactoryBot.define do
  @names = CSV.readlines('./test/fixtures/names.csv', headers: true)

  sequence :email do |n|
    "user#{n}@domain.com"
  end

  sequence(:name, (0..600).cycle) do |n|
    @names['name'][n]
  end

  sequence(:lastname, (0..600).cycle) do |n|
    @names['name'][n] + 'son'
  end

  sequence(:task_name) do |n|
    "Example task name no.#{n}"
  end

  sequence(:task_description) do |n|
    "Example #{n} description\n"\
    "Second line of discription\n"\
    'Third line of description'
  end

  sequence(:user_type, (0..2).cycle) do |n|
    user_types = %w[Admin Manager Developer]
    user_types[n]
  end

  sequence(:password_hash) do |n|
    "pass#{n}hash"
  end
end
