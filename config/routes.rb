Rails.application.routes.draw do
  
  get 'relationships/followings'
  get 'relationships/followers'
  root to: 'homes#top'
  
  # get 'books/index'
  # get 'books/show'
  get '/home/about' => 'homes#about', as: 'about'
  
  devise_for :users
  
  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  
  resources :books, only: [:index, :show, :edit, :create, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  
end
