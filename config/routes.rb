Rails.application.routes.draw do
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :sessions, only: [:create, :destroy]

  resources :recipes, only: [:create]
  resources :restaurants, only: [:create]
end
