# frozen_string_literal: true

require "rails_helper"

RSpec.describe CartsController, type: :routing do
  describe "routing" do
    it "routes to #show" do
      expect(get: "cart").to route_to("carts#show")
    end
    it "routes to #add" do
      expect(put: "cart/add/1").to route_to("carts#add", product_id: "1")
    end
    it "routes do #remove" do
      expect(put: "cart/remove/1").to route_to("carts#remove", product_id: "1")
    end
  end
end
