Rails.application.routes.draw do

  root to: 'toppages#index'

  get 'signup', to: 'users#new'

  resources :users, only: [:index, :show, :new] do
    resources :articles, only: [:index, :new, :create, :show, :update, :edit, :destroy] do
      resources :comments
    end
  end

  resources :teams, only: [:index, :show, :new, :create] do
    resources :users, only: [:new ,:create]

    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
  end
end
