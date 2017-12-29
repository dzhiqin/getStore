Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
  resources :products do
    resources :posts do
      member do
        post :vote
        post :unvote
      end
    end
    member do
      post :add_to_cart
      post :cart_and_buy
      post :like
      post :unlike
      post :new_post
    end
  end
  namespace :admin do
    resources :products
    resources :orders do
      member do
        post :cancel
        post :ship
        post :shipped
        post :return
      end
    end
  end
  resources :carts do
    collection do
      delete :clean
      post :checkout
    end
  end
  resources :cart_items
  resources :orders do
    member do
      post :pay_with_alipay
      post :pay_with_weixin
      post :apply_to_cancel
    end
  end
  namespace :account do
    resources :orders
    resources :favorites
  end
end
