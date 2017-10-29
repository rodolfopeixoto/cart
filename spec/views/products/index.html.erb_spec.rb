# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "products/index", type: :view do
  before(:each) do
    assign(:products, [
      Product.create!(
        name: "Name",
        price: 2.5
      ),
      Product.create!(
        name: "Name",
        price: 2.5
      )
    ])
  end

  it "renders a list of products" do
    render
    assert_select ".col-md-12 h5", text: "Name".to_s, count: 2
    assert_select ".col-md-12 p", text: "$2.5", count: 2
  end
end
