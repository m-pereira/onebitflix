Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :favorites, path: 'my_list', only: %i[index create]
      delete 'my_list/:type/:id', to: 'favorites#destroy', as: :favorite

      resources :reviews, only: %i[index create]
      resources :searchs, path: 'search', only: :index
      resources :series, only: :show
      resources :movies, only: :show do
        member do
          get '/executions', to: 'executions#show'
          put '/executions', to: 'executions#update'
        end
      end

      # resources :recommendations, only: :index
    end
  end
end
