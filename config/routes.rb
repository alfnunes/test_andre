Rails.application.routes.draw do
  get "/" => "home#index"
  resources :factory
  resources :models  
end
