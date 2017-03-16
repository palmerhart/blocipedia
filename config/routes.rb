Rails.application.routes.draw do
  
  resources :charges, only: [:new, :create]
  
  resources :wikis
  
  devise_for :users
  
  resources :users do
    member do
      post :downgrade
    end
  end
  
  get "welcome/index"
  get "welcome/about"

  root 'welcome#sign_up'
end
