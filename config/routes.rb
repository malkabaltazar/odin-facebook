Rails.application.routes.draw do
  devise_scope :user do
    root 'devise/registrations#new'
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:index, :show]
  resources :notifications, only: [:create, :destroy]
  resources :friendships, only: [:create, :destroy]
  resources :posts, only: [:index, :create, :destroy]
  resources :likes, only: [:index, :create, :destroy]
  resources :comments, only: [:create, :destroy]
end
