Rails.application.routes.draw do
  get "sessions/new"
  get "users/show"

  root "static_pages#home"
  get "/signup", to: "users#new"
  get "/help", to: "static_pages#help"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users
  resources :categories
  resources :words
  resources :lessons

  namespace :admin do
    root "static_pages#home"
    resources :categories
    resources :words
    resources :users
  end
end
