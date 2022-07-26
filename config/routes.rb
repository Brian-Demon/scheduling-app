Rails.application.routes.draw do
  root "pages#index"

  namespace :api do
    namespace :v1 do
      resources :users
      resources :schedules
      resources :shifts
      resources :tests
    end
  end

  get "/auth/:provider/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get '/logged_in', to: 'sessions#is_logged_in?'

  get '*path', to: 'pages#index', via: :all
end
