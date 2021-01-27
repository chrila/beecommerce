Rails.application.routes.draw do
  devise_for :users
  devise_for :admins

  authenticate :admin do
    resources :products
    resources :categories
  end
  
  root 'home#index'
end
