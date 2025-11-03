Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "igdb/search", to: "igdb_searches#show", as: :igdb_search

  resources :backlog_items
  resources :games, param: :igdb_id do
    resources :reviews do
      resources :comments, only: [:create]
    end
  end
  get "friends/search", to: "friends#search", as: :search_friends
  resources :friends
  resource :registration, only: [:new, :create]
  resources :users do
    resources :comments, only: [:create]
  end
  root "backlog_items#index"

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
