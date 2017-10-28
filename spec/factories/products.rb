# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name "Book"
    price 1.5

    trait :invalido do
      name { nil }
      price { nil }
    end
  end
end
