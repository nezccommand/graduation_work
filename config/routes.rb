Rails.application.routes.draw do
  root "top#index"
  devise_for :users, controllers: {
    registrations: "users/registrations",
    confirmations: "users/confirmations"
  }

  get "confirmation_sent", to: "static_pages#confirmation_sent", as: "confirmation_sent"
  resources :quizzes, only: %i[ show ] do
    post :answer, on: :member
    collection do
      get :result
    end
  end

  resources :samples, only: %i[ index show ]
  resource :mypage, only: %i[ show ]

  resource :simulation_email, only: %i[ new create ] do
    get :complete, on: :collection
  end

  namespace :admin do
    resources :quizzes
    resources :samples
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
