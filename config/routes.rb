Rails.application.routes.draw do
  root "pages#home"

  get "pages/home"
  get "up" => "rails/health#show", as: :rails_health_check

  resources :users, only: [:index, :show]

  resources :events do
    member do
      patch :publish
      patch :cancel
    end
  end

  resources :categories
  resources :venues
  resources :registrations
  resources :reviews

  resources :notifications do
    member do
      patch :mark_as_read
    end
  end
end