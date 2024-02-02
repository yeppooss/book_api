Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users, defaults: { format: :json }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      resources :books, only: %w[index]
    end
  end
end
