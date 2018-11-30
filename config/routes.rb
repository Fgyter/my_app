Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :photos do
    member do
      post :to_work
      post :to_cancel
      post :to_ready
      post :to_pay
    end
    collection do
      post :ready_image
    end
  end
  devise_for :users
  root 'pages#landing'
  get 'pages/about'
end
