require 'sidekiq/web'

Rails.application.routes.draw do
  namespace :api do
    jsonapi_resources :candidates
    mount Sidekiq::Web => '/sidekiq'
  end
end
