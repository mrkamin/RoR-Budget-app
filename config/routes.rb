Rails.application.routes.draw do
  resources :payments

  # Commented to allow defaulting routing to splash index
  # devise_scope :user do
  #   # root 'devise/sessions#new'  
  # end

  root 'splash#index' 
  devise_for :users 

  get '/splash', to: 'splash#index', as: 'splash'

  resources :users, only: [:index, :show]
      resources :categories do
        resources :payments
    end
    

  # Defines the api routes
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
       resources :users, only: [:index, :show]
      resources :categories do
        resources :payments
    end
    end
  end

end