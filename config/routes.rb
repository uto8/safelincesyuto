Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    get '/dashboard', to: 'pages#index'
    get '/user_allowances', to: 'user_allowances#index'
    get 'user_allowances/:month', to: 'user_allowances#list', as: :admin_user_allowance_list
    get 'user_allowances/:month/user/:id', to: 'user_allowances#allowance', as: :admin_user_allowance_allowance
    resources :licenses
    resources :users
    resources :projects
  end
end
