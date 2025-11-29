Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :quizzes, only: [:index, :show] do
    post :submit
  end

  resources :quiz_submissions, only: [:index, :show]

  root "quizzes#index"
end
