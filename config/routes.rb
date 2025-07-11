Rails.application.routes.draw do
  root to: "homes#top"
  get "home/about",to: "homes#about"
  devise_for :users
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :post_comments, only: [:create, :destroy]
    resource :favorite, only: [:create, :destroy]
  end
  
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
        get "followings" => "relationships#followings", as: "followings"
        get "followers"  => "relationships#followers", as: "followers"
  end
  get "/search", to:"searches#search"
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
