Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users, only: [:index, :show]
  get 'friends', to: 'friends#index'

  resources :friend_requests, only: [ :update, :destroy]
  post 'friend_requests/:id', to: 'friend_requests#create'

  resources :comments, only: [ :create ] do
    post 'like', to: 'likes#create'
    delete 'like', to: 'likes#destroy'
  end

  resources :posts do
    post 'like', to: 'likes#create'
    delete 'like', to: 'likes#destroy'
    resources :comments, only: [ :create ]
  end

  get 'static_pages/home'
  get 'static_pages/help'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/timeline', to: 'posts#index'
  root to: redirect("/timeline")

end
