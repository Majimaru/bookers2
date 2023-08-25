Rails.application.routes.draw do
  
  root to: 'homes#top'
  
  # get 'books/index'
  # get 'books/show'
  get '/home/about' => 'homes#about', as: 'about'
  
  devise_for :users
  
  resources :users, only: [:index, :show, :edit, :update]
  resources :books, only: [:index, :show, :edit, :create, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  
end
