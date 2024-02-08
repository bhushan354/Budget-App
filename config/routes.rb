# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions'
  }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  get 'pages/splash'
  get 'pages/about'

  devise_scope :user do
    authenticated :user do
      root :to => 'categories#index', as: :authenticated_root
    end
    unauthenticated :user do
      root :to => 'pages#splash', as: :unauthenticated_root
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :categories do 
   resources :payments
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
