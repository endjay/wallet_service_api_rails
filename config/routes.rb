Rails.application.routes.draw do
  resources :users, only: [:index, :create, :destroy]
  resources :wallets, only: [:index, :create, :destroy]
  resources :transactions, only: [:index, :create, :update]
end
