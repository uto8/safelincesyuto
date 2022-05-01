Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    resources :users
  end
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    get '/dashboard', to: 'pages#index'
    resources :licenses
  end
end
