Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  post '/login', to: 'authentication#login'
  post 'orders', to: 'orders#create'

  resources :inventory, only: [] do
    collection do
      get 'index', to: 'inventory#index'
      get 'show', to: 'inventory#show'
      post 'restock', to: 'inventory#restock'
      post 'check_availability', to: 'inventory#check_availability'
    end
  end

  resources :pizzas, only: [:index] do
    post 'add_topping', on: :collection
  end
end
