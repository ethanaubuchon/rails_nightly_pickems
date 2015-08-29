Rails.application.routes.draw do
  resources :scores

  resources :games

  resources :teams

  resources :picks

  devise_for :users, :controllers => { registrations: 'registrations' }

  root 'games#index'
end
