# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    all_products(current_user_cart)
    @cart_products = []
    puts "PRODUTOS = #{Product.find(@cart_ids)}"
    @cart_products.concat Product.find(@cart_ids)
  end

  def add
    if product?(params[:product_id]) #nil? true
      puts 'O produto existe'
      new_quantity((params[:product_id]), params[:quantity])
    else
      puts 'O produto não existe'
      add_product(params[:product_id])
      product = $redis.keys("cart#{current_user.id}:product#{params[:product_id]}")
      puts "Produto: #{product} "
      add_quantity(params[:product_id], params[:quantity])
      quantity = $redis.keys("cart#{current_user.id}:product#{params[:product_id]}:quantity")
      puts "QuantidadeController: #{quantity}"
    end
    # $redis.hincrby(current_user_cart, "quantity", params[:quantity])
    render json: current_user.cart_count, status: 200
  end

  def remove
    destroy_redis("#{current_user_cart_product}#{params[:product_id]}:quantity")
    destroy_redis("#{current_user_cart_product}#{params[:product_id]}")
    render json: current_user.cart_count, status: 200
  end

  private

  def current_user_cart
    "cart#{current_user.id}"
  end

  def current_user_cart_product
    "#{current_user_cart}:product"
  end

  def current_quantity(product_id)
    show_redis("#{current_user_cart_product}#{product_id}:quantity").to_i
  end

  def add_quantity(product_id, quantity)
    create_redis("#{current_user_cart_product}#{product_id}:quantity", quantity)
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
    search_redis("#{current_user_cart_product}*").map { |key| @cart_ids << product(key) }
  end

  def product(key)
    show_redis(key)
  end

  def add_product(product_id)
    puts create_redis("#{current_user_cart_product}#{product_id}", product_id)
  end

  def create_redis(key,value)
    $redis.set(key,value)
  end

  def show_redis(key)
    $redis.get(key)
  end

  def search_redis(key)
    $redis.keys(key)
  end

  def destroy_redis(key)
    $redis.del(key)
  end
end
