Rails.application.routes.draw do
  get "users/show"

  root "static_pages#home"
  get "/signup", to: "users#new"
  get  "/help", to: "static_pages#help"
  post "/signup",  to: "users#create"
  resources :users
end
