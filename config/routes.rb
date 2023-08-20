Rails.application.routes.draw do
  
  root to: 'homes#top'
  
  get 'books/index'
  get 'books/show'
  get '/homes/about' => 'homes#about', as: 'about'
  
  devise_for :users
  
  resources :users, only: [:index, :show, :edit, :update]
  resources :books, only: [:index, :show, :edit, :create, :update, :destroy]
  
end
