# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path_names: { sign_in: 'login', sign_up: 'register', sign_out: 'logout' }
  root 'products#index'
  resources :products
end
