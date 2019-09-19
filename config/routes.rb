Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations', confirmations: 'users/confirmations', passwords: 'users/passwords', sessions: 'users/sessions', unlocks: 'users/unlocks', omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :tournaments
  resources :games

  root to: 'tournaments#index'

  get '/users/:id', to: 'users#show', as: 'user'

  get '/matches/', to: 'matches#index', as: 'match'

  # get '/tournaments/participate/:id', to: 'tournaments#add_participant', as: 'add_participant'

  # Tournament Registrations
  post '/tournaments/participate/:tournament_id/:game_id', to: 'tournaments#add_participant', as: 'add_participant'
  post '/tournaments/not_participate/:tournament_id/:game_id', to: 'tournaments#destroy_participant', as: 'destroy_participant'

  # Matches management
  post '/tournaments/generate_matches/:tournament_id/:game_id', to: 'tournaments#generate_matches', as: 'generate_matches'
  post '/tournaments/destroy_matches/:tournament_id/:game_id', to: 'tournaments#destroy_matches', as: 'destroy_matches'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
