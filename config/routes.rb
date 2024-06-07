# frozen_string_literal: true

Rails.application.routes.draw do
  # NOTE: I'm not using `:id` for anything, but just in case you need it.
  post '/fields/:model(/:id)/build/:association(/:partial)', to: 'fields#build', as: :build_fields

  resources :cocktails do
    get :add_ingredient, on: :collection
    post :index, on: :collection
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
