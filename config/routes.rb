Rails.application.routes.draw do
  root "pages#home"

  get "pages/home"
  get "up" => "rails/health#show", as: :rails_health_check

  resources :users, only: [:index, :show]
  resources :events, only: [:index, :show]
  resources :categories, only: [:index, :show]
  resources :venues, only: [:index, :show]
  resources :registrations, only: [:index, :show]
  resources :reviews, only: [:index, :show]
  resources :notifications, only: [:index, :show]
end