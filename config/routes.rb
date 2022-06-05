Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    get '/dashboard', to: 'pages#index'
    resources :licenses
    resources :users
    resources :projects
    get 'projects/:id/post', to: 'projects#post', as: :post_project_path
  end
end
