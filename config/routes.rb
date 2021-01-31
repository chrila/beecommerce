Rails.application.routes.draw do
  resources :variants
  devise_for :users
  devise_for :admins

  authenticate :admin do
    resources :products
    resources :categories
  end

  resource :cart, only: [:show, :update] do
    member do
      post :pay_with_paypal
      get :process_paypal_payment
    end
  end
  
  root 'home#index'
end
