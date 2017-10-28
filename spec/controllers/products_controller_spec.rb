# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'GET index' do
    let(:user) { FactoryBot.create(:user) }
    before do
      sign_in(user)
    end
    it 'renders the index template' do
      get :index
      expect(response).to be_success
    end
  end

  describe 'GET show' do
    let(:user) { FactoryBot.create(:user) }
    let(:product) { FactoryBot.create(:product) }
    subject { get :show, params: { id: product } }
    before do
      sign_in(user)
    end
    
    it 'assigns the requested product to @product' do 
      expect(subject).to be_success
    end     
  end

  describe 'GET #edit' do
    let(:user) { FactoryBot.create(:user) } 
    let(:product) { FactoryBot.create(:product) }
    
    before do
      sign_in(user) 
    end 
    
    it 'returns success response' do
      get :edit, params: { id: product }
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    
    let(:product) { FactoryBot.build(:product) } 
    let(:user) { FactoryBot.create(:user) }  
    
    before do
      sign_in(user) 
    end

    context 'with valid params' do
      let(:product_valido) { attributes_for(:product) } 

      it 'creates a new product' do
        expect { post :create, params: { product: product_valido } }.to change(Product, :count).by(1)
      end

      it 'redirects to the created product' do
        post :create, params: { predio: product_valido }
        expect(response).to redirect_to(Product.last)
      end
    end

    context 'with invalid params' do
      
      let(:product_invalido) { attributes_for(:product, :invalido) }

      it 'returns a success response' do
        post :create, params: { product: product_invalido }
        expect(response).to be_success
      end
    end

  end

  describe 'PUT #update' do
    let(:user) { FactoryBot.create(:user) }
    let(:product) { FactoryBot.create(:product) }
    before do
      sign_in(user)
    end
    context 'with valid params' do
      let(:valid_data) { FactoryBot.attributes_for(:product, nome: 'Lapis') }
      
      it 'updates the requested product' do
        put :update, params: { id: product, product: valid_data }
        product.reload
        expect(product.name).to eq('Lapis')
      end

      it 'redirects to the product' do
        put :update, params: { id: product, product: valid_data }
        expect(response).to redirect_to(product)
      end
    end

    context 'with invalid params' do
      let(:product_invalido) { attributes_for(:product, :invalido) }
      it 'return a success response' do
        put :update, params: { id: product, product: product_invalido }
        expect(response).to be_success
      end
    end
  end


  describe 'DELETE #destroy' do
    let(:user) { FactoryBot.create(:user) } 
    let(:product) { FactoryBot.create(:product) }
    
    before do
      sign_in(user) 
    end

    it 'destroy the requested product' do
      expect { delete :destroy, params: { id: product } }.to change(Product, :count).by(0)
    end

    it 'redirects to the predios list' do
      delete :destroy, params: { id: product}
      expect(response).to redirect_to(products_url)
    end
  end


end