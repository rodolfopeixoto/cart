# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { Faker::Book.title }
    price { Faker::Number.decimal(5) }

    trait :invalido do
      name { nil }
      price { nil }
    end
  end
end
