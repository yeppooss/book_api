Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'
  devise_for :users, defaults: { format: :json }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      resources :books, only: %w[index]

      namespace :admin do
        resources :users, only: %w[show], param: :user_id do
          member do
            resources :books, only: %w[index create destroy]
          end
        end
      end
    end
  end
end
