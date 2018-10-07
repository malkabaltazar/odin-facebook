Rails.application.routes.draw do
  devise_scope :user do
    root 'users/registrations#new'
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                    registrations: 'users/registrations' }
  resources :users, only: [:index, :show]
  resources :notifications, only: [:create, :destroy]
  resources :friendships, only: [:create, :destroy]
  resources :posts, only: [:index, :create, :destroy]
  resources :likes, only: [:index, :create, :destroy]
  resources :comments, only: [:create, :destroy]
end
