Community::Application.routes.draw do
  devise_for :users
  root to: 'welcome#dashboard'
  resources :residents

  resources :buildings do
    resources :units
  end

  resources :payments
  resources :accounts

  resources :transactions do
    collection do
      post 'withdraw'
      post 'deposit'
      post 'transfer'
    end
  end

  resources :transaction_types
end

