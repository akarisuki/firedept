Rails.application.routes.draw do
  #ルートパスは/ではなく#をつける

  
  devise_for :users, :controllers => {
    sessions: 'users/sessions' ,
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest' #ゲストログイン用メソッド
  end

  root to: 'tweets#index' #トップページ

  resources :tweets
  resources :users, only: [:index, :show, :edit, :update]
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
