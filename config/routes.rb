Community::Application.routes.draw do
  devise_for :users
  root to: 'welcome#dashboard'
end
