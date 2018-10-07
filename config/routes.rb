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
  post '/places', to: 'places#search'
  delete '/logout', to: 'sessions#destroy'
  resources :places, only: [:index, :show]
  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
