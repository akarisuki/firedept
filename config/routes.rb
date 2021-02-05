Rails.application.routes.draw do
  get 'comments/create'
  devise_for :users
  root to: 'tweets#index'
  resources :tweets
  resources :users, only: :show

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
