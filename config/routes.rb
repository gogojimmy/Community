Community::Application.routes.draw do
  devise_for :users
  root to: 'welcome#dashboard'
  resources :residents

  resources :buildings do
    resources :units
  end

  resources :payments
end
