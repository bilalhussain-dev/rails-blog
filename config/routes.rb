Rails.application.routes.draw do
  get 'pages/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "pages#home"
  get "about", to: "pages#about"

  # Create Articles Listings
  resources :articles

  get "signup", to: "users#new"
  resources :users, except: [:new]

  # Login to SESSION
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
end
