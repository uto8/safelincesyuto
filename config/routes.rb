Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    get '/dashboard', to: 'pages#index'
    resources :licenses
    resources :users
    resources :projects
    get 'projects/:id/post', to: 'projects#edit_member_license', as: :post_project_path
    resources :projects do
      collection do
        get 'search'
      end
    end
  end
end
