Rails.application.routes.draw do
  root to: "home#index"

  resources :users do
    get "account", to: "users#show", on: :member
    patch "account", to: "users#update", on: :member
  end

  get "register", to: "registrations#new"
  post "register", to: "registrations#create"

  get "login", to: "sessions#new"
  get "/auth/:provider/callback", to: "sessions#create"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "password/reset", to: "password_resets#new"
  post "password/reset", to: "password_resets#create"
  get "password/reset/edit", to: "password_resets#edit"
  patch "password/reset/edit", to: "password_resets#update"

  resources :shifts
  
  resources :schedules
end
