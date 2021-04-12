Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "homes#top"
  get "homes/about" => "homes#about"

  #get 'users/mypage' => 'users#show', as: 'mypage'
  #get 'users/information/edit' => 'users#edit', as: 'edit_information'
  #patch 'users/information' => 'users#update', as: 'update_information'
  #put 'users/information' => 'users#update'
  #get 'users/unsubscribe' => 'users#unsubscribe', as: 'confirm_unsubscribe'
  #patch 'users/withdraw' => 'users#withdraw', as: 'withdraw_customer'
  #put 'users/withdraw' => 'users#withdraw'

  resources :restaurants, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  resources :users, only: [:index, :show, :edit, :update]
end
