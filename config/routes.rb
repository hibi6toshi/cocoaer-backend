Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create show] do
        resources :articles, only: [:index], module: 'user'
        resources :projects, only: [:index], module: 'user'
        resources :forums, only: [:index], module: 'user'
      end
      resources :articles, only: %i[index show create edit update destroy]
      resources :projects, only: %i[index show create edit update destroy]
      resources :forums, only: %i[index show create edit update destroy]
      resources :piety_categorys, only: %i[index]
      resources :piety_targets, only: %i[index]
      resources :favorites, only: %i[index create destroy]
      resource :my_post, only: %i[show]
    end
  end
end
