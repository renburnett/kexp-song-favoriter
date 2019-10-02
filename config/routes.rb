Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :songs, only: [:index, :show, :new, :create]  
  resources :users, only: [:index, :show]
  # resources :albums, only: [:index, :show]
  # resources :artists, only: [:index, :show]
end