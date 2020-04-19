# frozen_string_literal: true

Rails.application.routes.draw do
  resources :planes do
    get 'take_off', on: :member
    post 'enqueue', on: :collection
  end

  root to: 'planes#index'
end
