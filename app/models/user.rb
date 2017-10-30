# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true

  def cart_count
    @quantity = []
    keys_quantity = $redis.keys("cart#{id}:product*:quantity")
    keys_quantity.map { |key| @quantity << $redis.get(key).to_i }
    @quantity.reduce(0, :+)
  end
end
