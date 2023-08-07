Rails.application.routes.draw do
  get '/health_check', to: 'health_checks#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create show destroy] do
        resources :articles, only: [:index], module: 'user'
        resources :projects, only: [:index], module: 'user'
        resources :forums, only: [:index], module: 'user'
      end
      resources :articles, only: %i[index show create edit update destroy] do
        resources :comments, only: %i[index create update destroy], module: :articles
      end
      resources :projects, only: %i[index show create edit update destroy] do
        # resources :comments, only: %i[index create update destroy], module: :projects
      end
      resources :forums, only: %i[index show create edit update destroy] do
        resources :comments, only: %i[index create update destroy], module: :forums
      end
      resources :piety_categorys, only: %i[index]
      resources :piety_targets, only: %i[index]
      resources :favorites, only: %i[index create destroy]
      resource :my_post, only: %i[show]
      resource :profile, only: %i[show update]
    end
  end
end
