Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations', confirmations: 'users/confirmations', passwords: 'users/passwords', sessions: 'users/sessions', unlocks: 'users/unlocks', omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :tournaments
  resources :games
  resources :matches

  root to: 'tournaments#index'

  get '/users/:id', to: 'users#show', as: 'user'


  # get '/tournaments/participate/:id', to: 'tournaments#add_participant', as: 'add_participant'

  # Tournament Registrations
  post '/tournaments/participate/:tournament_id/:game_id',      to: 'tournaments#add_participant',      as: 'add_participant'
  post '/tournaments/not_participate/:tournament_id/:game_id',  to: 'tournaments#destroy_participant',  as: 'destroy_participant'

  # Matches management
  post '/tournaments/generate_matches/:tournament_id/:game_id', to: 'tournaments#generate_matches',     as: 'generate_matches'
  post '/tournaments/destroy_matches/:tournament_id/:game_id',  to: 'tournaments#destroy_matches',      as: 'destroy_matches'
  post '/matches/generate_winners',                             to: 'matches#generate_winners',         as: 'match_generate_winners'

  get '/matches/:id/edit', to: 'matches#edit', as: 'match_edit'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
