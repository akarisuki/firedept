Rails.application.routes.draw do

  get 'rooms/index'
  get 'rooms/create'
  get 'rooms/show'
  get 'messages/create'
  get 'messages/edit'
  get 'messages/update'
  get 'messages/destroy'
  devise_for :users
  root to: 'tweets#index'
  namespace :tweets do
    resources :searches, only: :index
  end
  resources :tweets do 
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
  
  resources :users, only: [:index, :show] do
    member do
      get :likes, :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]

end
