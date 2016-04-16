Rails.application.routes.draw do
  resources :scores

  # resources :games
  get 'games' => 'games#index'
  get 'admin/games' => 'games#admin'
  post 'games' => 'games#create'

  # resources :teams

  # resources :picks
  get 'picks' => 'picks#index'
  post 'picks' => 'picks#create'

  get '/standings/week' => 'standings#week'

  devise_for :users, :controllers => { registrations: 'registrations' }

  root 'games#index'
end
