Rails.application.routes.draw do
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :sessions, only: [:create, :destroy]

  resources :recipes, only: [:create]
  resources :restaurants, only: [:create]

  post '/set_allergen', to: 'users#set_allergen'
  post '/sign_up', to: 'users#sign_up'
end
