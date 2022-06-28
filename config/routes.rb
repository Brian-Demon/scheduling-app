Rails.application.routes.draw do
  root "pages#index"

  namespace :api do
    namespace :v1 do
      get "login", to: "sessions#new"
      post "login", to: "sessions#create"
      delete "logout", to: "sessions#destroy"
      resources :users
    end
  end

  get '*path', to: 'pages#index', via: :all
end
