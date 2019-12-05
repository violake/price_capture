# frozen_string_literal: true

Rails.application.routes.draw do
  root 'coins#index'
  resources :coins, only: %i[index show]
  get 'capture', to: 'coins#capture'
end
