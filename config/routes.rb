Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations', confirmations: 'users/confirmations', passwords: 'users/passwords', sessions: 'users/sessions', unlocks: 'users/unlocks', omniauth_callback: 'users/omniauth_callbacks' }

  resources :tournaments
  resources :games

  root to: 'tournaments#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
