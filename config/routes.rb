Shutters::Application.routes.draw do

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :photos, :except => [:edit, :update]
  resources :users, :only => [:new, :create]
  resources :sessions, :only => [:new, :create, :destroy]
  resources :tags, :only => :create
  resources :favorites, :only => [:create, :destroy]
  root to: 'photos#index'
end
