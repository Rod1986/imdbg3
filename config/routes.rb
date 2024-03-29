Rails.application.routes.draw do

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :tags

  resources :movies do
    member do
      delete 'delete_tag/:tag_id', to: 'movies#delete_tag', as: :delete_tag
    end
  end

  root 'movies#index'

end
