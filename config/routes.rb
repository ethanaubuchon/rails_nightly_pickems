Rails.application.routes.draw do
  resources :scores

  # resources :games
  get 'games' => 'games#index'
  get 'games/search' => 'games#search'
  get 'admin/games' => 'games#admin'
  post 'games' => 'games#create'
  delete 'games/:id(.:format)' => 'games#destroy'

  # resources :teams

  # resources :picks
  get 'picks' => 'picks#index'
  post 'picks' => 'picks#create'

  get '/standings/week' => 'standings#week'

  devise_for :users, :controllers => { registrations: 'registrations' }

  root 'games#index'
end
