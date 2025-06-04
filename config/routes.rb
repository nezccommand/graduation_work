Rails.application.routes.draw do
  root "top#index"
  devise_for :users
  resources :quizzes, only: %i[ show ] do
    post :answer, on: :member
    collection do
      get :result
    end
  end

  resources :words, only: %i[ index show ]

  namespace :admin do
    resources :quizzes
    resources :words
    resources :tags
  end

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
