Rails.application.routes.draw do
  
  get 'books/index'
  get 'books/show'
  root to: 'homes#top'
  devise_for :users
  
  get '/homes/about' => 'homes#about', as: 'about'
  
  resources :users, only: [:index, :show, :edit, :update]
  resources :books, only: [:index, :show, :edit, :create, :destroy]
  
end
