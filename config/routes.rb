Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  namespace :teams do
    resources :members, only: [:index]
  end
  namespace :members do 
    resources :projects,only: [:create]
    resources :teams,only: [:update]
   
  end
  namespace :projects do 
    resources :members,only: [:index]
  end
  resources :members
  resources :projects
  resources :teams
  # Defines the root path route ("/")
  # root "posts#index"
end
