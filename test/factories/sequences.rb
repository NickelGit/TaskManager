# frozen_string_literal: true

require 'csv'

FactoryBot.define do
  @names = CSV.readlines('./test/fixtures/names.csv', headers: true)

  sequence :email do |n|
    "user#{n}@domain.com"
  end

  sequence(:first_name, (0..600).cycle) do |n|
    @names['name'][n]
  end

  sequence(:last_name, (0..600).cycle) do |n|
    @names['name'][n] + 'son'
  end

  sequence(:task_name, aliases: [:name]) do |n|
    "Example task name no.#{n}"
  end

  sequence(:description) do |n|
    "Example #{n} description\n"\
    "Second line of discription\n"\
    'Third line of description'
  end

  sequence(:password) do |n|
    "pass#{n}"
  end

  sequence(:string) do |n|
    "string#{n}"
  end
end
