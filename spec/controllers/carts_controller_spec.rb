# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:product) { FactoryBot.create(:product) }
  let(:redis) { Redis.new(host: 'redis') }
  
  describe "#destroy_redis" do
    before do
      redis.set("cart#{user.id}:product#{product.id}", product.id)
    end
    it "should be to destroy the record" do
      redis.del("cart#{user.id}:product#{product.id}")
      product1 = redis.get("cart#{user.id}:product#{product.id}")
      expect(product1).to be_nil
    end
  end

  describe "#add_product" do
    it "should be to add product" do 
      redis.set("cart#{user.id}:product#{product.id}", product.id)
      product1 = redis.get("cart#{user.id}:product#{product.id}")
      expect(product1).to eq "2"
    end
  end
end
