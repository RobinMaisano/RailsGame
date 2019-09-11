Rails.application.routes.draw do

  resources :tournaments
  resources :games

  root to: 'tournaments#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
