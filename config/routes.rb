require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'dashboard#show'

  resources :hosts, only: %i(index edit update)
  resources :macs, only: %i(edit update)

  mount Sidekiq::Web => '/sidekiq'
end
