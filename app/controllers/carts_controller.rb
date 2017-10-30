# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    all_products(current_user_cart)
    @cart_products = Array.new
    @cart_products.concat Product.find(@cart_ids)
  end

  def add
    unless product?(params[:product_id])
      new_quantity((params[:product_id]), params[:quantity].to_i)
    else
      add_product(params[:product_id])
      add_quantity(params[:product_id], params[:quantity])
      add_price(params[:product_id], params[:price])
    end
    render json: current_user.cart_count, status: 200
  end

  def remove
    destroy_redis("#{current_user_cart_product}#{params[:product_id]}:quantity")
    destroy_redis("#{current_user_cart_product}#{params[:product_id]}")
    destroy_redis("#{current_user_cart_product}#{params[:product_id]}:price")
    render json: current_user.cart_count, status: 200
  end

  private

  def current_user_cart
    "cart#{current_user.id}"
  end

  def current_user_cart_product
    "#{current_user_cart}:product"
  end 

  def add_price(product_id, price) 
    create_redis("#{current_user_cart_product}#{product_id}:price", price)
    $redis.expire("#{current_user_cart_product}#{product_id}:price", 2.days)
  end

  def current_quantity(product_id)
    show_redis("#{current_user_cart_product}#{product_id}:quantity").to_i
  end

  def add_quantity(product_id, quantity)
    create_redis("#{current_user_cart_product}#{product_id}:quantity", quantity)
    $redis.expire("#{current_user_cart_product}#{product_id}:quantity", 2.days)
  end

  def remove_quantity(product_id)
    destroy_redis("#{current_user_cart_product}#{product_id}:quantity")
  end

  def new_quantity(product_id, quantity)
    current_quantity = current_quantity(product_id)
    total_quantity = current_quantity + quantity
    remove_quantity(product_id)
    add_quantity(product_id, quantity)
  end

  def product?(product_id)
    show_redis("#{current_user_cart_product}#{product_id}").nil?
  end

  def all_products(cart_product)
    @cart_ids = Array.new
    @keys = Array.new
    keys_product = Array.new
    keys_product.concat(search_redis("#{current_user_cart_product}*")).each { |key| @keys << /#{current_user_cart_product}\d/.match(key).to_s }
    @keys.uniq.map { |key| @cart_ids << show_redis(key.to_s) }
  end

  def add_product(product_id)
    create_redis("#{current_user_cart_product}#{product_id}", product_id)
    $redis.expire("#{current_user_cart_product}#{product_id}", 2.days)
  end

  def create_redis(key,value)
    $redis.set(key.to_s,value)
  end

  def show_redis(key)
    $redis.get(key.to_s)
  end

  def search_redis(key)
    $redis.keys(key.to_s)
  end

  def destroy_redis(key)
    $redis.del(key.to_s)
  end

end
