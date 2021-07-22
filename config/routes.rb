Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :favorites, path: 'my_list', only: %i[index create]
      delete 'my_list/:type/:id', to: 'favorites#destroy', as: :favorite
    end
  end
end
