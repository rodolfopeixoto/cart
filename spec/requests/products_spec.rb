# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Products", type: :request do
  let(:user) { FactoryBot.create(:user) }

  before do
    login_as(user)
  end

  describe "GET /products" do
    it "works! (now write some real specs)" do
      get products_path
      expect(response).to have_http_status(200)
    end
  end
end
