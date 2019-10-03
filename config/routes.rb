Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'users/favorites/:id', to: 'users#save_favorite', as: 'save_favorite'
  get 'users/favorites', to: 'users#favorites', as: 'favorites'
  delete 'users/favorites/:id', to: 'users#destroy_favorite', as: 'destroy_favorite'

  resources :songs, only: [:index, :show, :new, :create]  
  resources :users, only: [:show, :new, :create]
  root 'songs#index'

  get '/logout', to: "auth#logout", as: 'logout'
  get '/login', to: 'auth#login', as: 'login'
  post '/login', to: 'auth#verify' #as: 'verify'
  
end