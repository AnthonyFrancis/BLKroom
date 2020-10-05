Rails.application.routes.draw do
  
  resources :rooms do
    resource :subscriptions
  end

  #get "posts/unsubscribe/:unsubscribe_hash" => "posts#unsubscribe", :as => 'comment_unsubscribe'

  get :search, controller: "application"

  
  resources :posts do
    member do 
      put "vote", to: "posts#vote"
    end
    resources :comments, module: :posts do
      member do 
        put "vote", to: "comments#vote"
      end
    end
  end

  devise_for :users
  root to: "posts#index"
  resources :users, only: [:show], as: "profile"
  get "about" => "home#about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
