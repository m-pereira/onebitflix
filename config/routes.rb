Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :favorites, path: 'my_list', only: %i[index create]
      delete 'my_list/:type/:id', to: 'favorites#destroy', as: :favorite

      resources :reviews, only: %i[index create]
      resources :searchs, path: 'search', only: :index
    end
  end
end
