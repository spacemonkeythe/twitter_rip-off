Rails.application.routes.draw do
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  get    "login"   => "sessions#new"
  post   "login"   => "sessions#create"
  delete "logout"  => "sessions#destroy"

  get "users/new"

  root to: "static_pages#home", as: "root"

  get "/signup", to: "users#new", as: "signup"

  get "static_pages/help", as: "help"
  get "static_pages/about", as: "about"
  get "static_pages/contact", as: "contact"

end
