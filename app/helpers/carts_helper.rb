# frozen_string_literal: true

module CartsHelper
  def quantity(user_id, product_id)
    quantity = $redis.get("cart#{user_id}:product#{product_id}:quantity")
    if quantity.nil?
      "1"
    else
      quantity
    end
  end

  def subtotal(user_id, product_id, price)
    quantity = $redis.get("cart#{user_id}:product#{product_id}:quantity")
    price.to_d * quantity.to_f
  end

  def total_calculator(user_id, product_id, price)
    @total += subtotal(user_id, product_id, price)
  end

  def check_price(user_id, product_id, price)
    old_price = $redis.get("cart#{user_id}:product#{product_id}:price")
    flash[:alert] = 'The price has changed since your last visit' unless price == old_price
  end
end
