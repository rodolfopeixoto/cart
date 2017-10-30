# frozen_string_literal: true

class Product < ApplicationRecord
  validates :name, :price, presence: true

  def cart_action(current_user_id)
    "Add to"
  end
end
