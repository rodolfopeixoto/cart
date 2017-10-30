# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true

  def cart_count
    # $redis.get("cart#{id}", "quantity")
    total_quantity = $redis.keys("#cart{id}:product*:quantity").map { |key| puts $redis.get("#{key.to_i}") }
    total_quantity.reduce(0, :+)
  end
end
