Rails.application.routes.draw do
  root to: "homes#top"
  devise_for :users

  devise_scope :user do
    post "users_guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  get "/home/about" => "homes#about", as: "about"
  get "search" => "searches#search", as: "search"

  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get "followings" => "relationships#followings"
    get "followers" => "relationships#followers"
  end

  resources :books, only: [:index, :show, :edit, :create, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
end
