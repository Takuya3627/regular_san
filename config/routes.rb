Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "homes#top"
  get "homes/about" => "homes#about"

  resources :restaurants, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :restaurant_comments, only: [:index, :create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update]

  resources :reviews, only: [:index]
end
