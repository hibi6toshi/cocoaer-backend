Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create]
      resources :articles, only: %i[index show]
      resources :projects, only: %i[index]
      resources :forums, only: %i[index]
    end
  end
end
