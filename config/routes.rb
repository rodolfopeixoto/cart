# frozen_string_literal: true

Rails.application.routes.draw do
  resource :cart, only: [:show] do
    put 'add/:product_id/:quantity', to: 'carts#add', as: :add_to
    put 'remove/:product_id', to: 'carts#remove', as: :remove_from
  end

  devise_for :users, path_names: { sign_in: 'login', sign_up: 'register', sign_out: 'logout' }
  root 'products#index'
  resources :products
end
