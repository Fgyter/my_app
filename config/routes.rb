Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :photos
  devise_for :users
  root 'pages#landing'
  get 'pages/about'
end
