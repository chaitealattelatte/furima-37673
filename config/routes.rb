Rails.application.routes.draw do
  root to: 'items#index'
  resources :tweets, only: :index
end
