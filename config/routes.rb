Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :restaurants, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]

    collection do
      #瀏覽所有餐廳最新動態
      get :feeds

      #人氣餐廳
      get :ranking
    end

    #瀏覽個別餐廳 Dashboard
    member do
      get :dashboard
      post :favorite
      post :unfavorite
      post :like
      post :unlike
    end

  end
  root "restaurants#index"
  resources :categories, only: :show
  resources :users, only: [:index, :show, :edit, :update] do

    member do
      get :friend_list
    end
  end
  #同member作法
  resources :followships, only: [:create, :destroy]
  resources :friendships, only: [:create, :destroy]

  namespace :admin do
    resources :restaurants
    resources :categories
    root "restaurants#index"
  end

end
