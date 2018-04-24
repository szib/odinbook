Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  # devise_for :users
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users, only: [:index, :show]

  get 'static_pages/home'
  get 'static_pages/help'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
end
