Rails.application.routes.draw do
  resources :scores

  resources :games

  resources :teams

  resources :picks

  get '/standings/week' => 'standings#week'

  devise_for :users, :controllers => { registrations: 'registrations' }

  root 'standings#week'
end
