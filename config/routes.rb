Rails.application.routes.draw do

  root to: 'homes#top'
  devise_for :users
  get 'home/about', to: 'homes#about', as: 'about'

  resources :books, only: [:index, :show, :edit, :create, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  
  resources :users, only: [:index, :show, :edit, :update]
end
