Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :quotes

  get "/users", to: "users#new"
  post "/users", to: "users#create"
  get "/me", to: "users#me"
  get "/login", to: "auth#new"
  post "/login", to: "auth#login"
  get "/logout", to: "auth#logout"

  root "quotes#index"
end
