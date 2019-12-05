# frozen_string_literal: true

Rails.application.routes.draw do
  root 'application#hello'
  resources :coins, only: %i[index show]
  get 'capture', to: 'coins#capture'
end
