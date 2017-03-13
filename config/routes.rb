Rails.application.routes.draw do
  
  resources :charges, only: [:new, :create]
  
  resources :wikis
  
  devise_for :users
  
  get "welcome/index"
  get "welcome/about"

  root 'welcome#sign_up'
end
