Rails.application.routes.draw do
  namespace :api do
    resources :user, only: [:show, :create, :update, :destroy]
    get 'users' => 'user#index'
    get 'typehead/:input' => 'user#index'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
