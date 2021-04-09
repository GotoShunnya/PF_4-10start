Rails.application.routes.draw do
  devise_for :users

  root to: "users#top"
  get "users/about"
  get "users/leave"
  get "users/withdraw"
  resources :users, only: [:show, :edit, :update]

  resources :posts, only: [:new, :index, :create, :show]
end
