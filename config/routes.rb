# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api, defaults: { format: :json } do
    resource :session
    resources :passwords, param: :token
    resources :users, only: [] do
      post 'follow', to: 'follows#create'
      delete 'unfollow', to: 'follows#destroy'
    end
    scope :users do
      resources :sleep_records, only: [:index] do
        collection do
          post :clock_in
          put :clock_out
        end
      end
      get 'following/sleep_records', to: 'sleep_records#following_sleep_record'
      get 'followers', to: 'follows#follower'
      get 'followees', to: 'follows#followee'
    end
  end
end
