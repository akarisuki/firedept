Rails.application.routes.draw do
  get 'users/index'
  get 'users/edit'
  get 'users/show'
  devise_for :users, :controllers => {
    sessions: 'users/sessions' 
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest' #ゲストログイン用メソッド
  end
  resources :users, only: [:index, :show, :edit, :update]
  
  root  'tweets#index' #トップページ
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
