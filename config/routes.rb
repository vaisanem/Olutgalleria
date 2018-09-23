Rails.application.routes.draw do
  resources :memberships
  resources :beer_clubs
  resources :users
  resources :beers
  resources :breweries
  root 'breweries#index'
  get 'kaikki_bisset', to: 'beers#index'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  delete '/logout', to: 'sessions#destroy'
  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
