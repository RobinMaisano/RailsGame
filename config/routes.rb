Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations', confirmations: 'users/confirmations', passwords: 'users/passwords', sessions: 'users/sessions', unlocks: 'users/unlocks', omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :tournaments
  resources :games

  root to: 'tournaments#index'

  get '/users/:id', to: 'users#show', as: 'user'

  # get '/tournaments/participate/:id', to: 'tournaments#add_participant', as: 'add_participant'

  post '/tournaments/participate/:tournament_id/:game_id', to: 'tournaments#add_participant', as: 'add_participant'

  post '/tournaments/not_participate/:tournament_id/:game_id', to: 'tournaments#destroy_participant', as: 'destroy_participant'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
