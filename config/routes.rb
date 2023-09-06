Rails.application.routes.draw do
  
  root to: 'homes#top'
  devise_for :users
  
  get '/home/about' => 'homes#about', as: 'about'
  get 'search' => 'searches#search', as: 'search'
  get 'tag_search' => 'searches#tag_search', as: 'tag_search'
  
  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings'
    get 'followers' => 'relationships#followers'
  end
  
  resources :books, only: [:index, :show, :edit, :create, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  
end
