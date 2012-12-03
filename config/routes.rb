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
      get 'residents'
      post 'pay_management_fees'
    end
  end

  resources :transaction_types
end

