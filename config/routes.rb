Rails.application.routes.draw do


  root to: 'landing#index'
  get :about , to:'static_pages#about'

  resources :topics, except: [:show] do
    resources :posts, except: [:show] do
      resources :comments, expect: [:show]
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :edit, :create, :update]

  resources :password_resets, only: [:new, :create, :edit, :update]

    mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
