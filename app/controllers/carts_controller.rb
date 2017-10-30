# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    #eu quero todos os produtos relacionados ao id(usuario = current_user_cart) atual
    all_products(current_user_cart)
    # puts "#{cart_ids} WHATSUP"
    puts "TESTE:      #{@cart_ids}"
    @cart_products = []
    puts "PRODUTOS = #{Product.find(@cart_ids)}"
    @cart_products.concat Product.find(@cart_ids)
  end

  def add
    # $redis.hset(current_user_cart, "product", params[:product_id])

    unless quantity?(params[:product_id]) #nil? true
      current_quantity(params[:product_id]) + params[:quantity].to_i
    else
      add_product(params[:product_id])
      add_quantity(params[:product_id], params[:quantity])
    end
    # $redis.hincrby(current_user_cart, "quantity", params[:quantity])
    render json: current_user.cart_count, status: 200
  end

  def remove
    $redis.srem(current_user_cart, params[:product_id])
    render json: current_user.cart_count, status: 200
  end

  private

  def current_user_cart
    "cart#{current_user.id}"
  end

  def add_quantity(product_id, quantity)
    $redis.set("#{current_user_cart}:product#{product_id}:quantity", quantity)
  end

  def all_products(cart_product)
    @cart_ids = Array.new
    $redis.keys("#{cart_product}:product*").map { |key| @cart_ids << product(key) }
  end

  def product(key)
    $redis.get(key)
  end

  def add_product(product_id)
    $redis.set("#{current_user_cart}:product#{product_id}", product_id)
  end

  def current_quantity(product_id)
    $redis.get("#{current_user_cart}:product#{product_id}:quantity").to_i
  end

  def quantity?(product_id)
    $redis.get("#{current_user_cart}:product#{product_id}:quantity").nil?
  end
end
