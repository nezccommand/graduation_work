Rails.application.routes.draw do
  root "top#index"
  devise_for :users

  post 'quizzes/:id/answer', to: 'quizzes#answer', as: 'quizzes_answer'
  get 'quizzes/result', to: 'quizzes#result', as: 'quizzes_result'
  get 'quizzes/:id', to: 'quizzes#show', as: 'quizzes_show'

  namespace :admin do
    resources :quizzes
  end

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
