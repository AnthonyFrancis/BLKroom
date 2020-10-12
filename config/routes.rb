Rails.application.routes.draw do
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :rooms, :path => "blk" do
    resource :subscriptions
  end

  #get "posts/unsubscribe/:unsubscribe_hash" => "posts#unsubscribe", :as => 'comment_unsubscribe'

  get :search, controller: "application"

  
  resources :posts do
    resources :comments, module: :posts do
    end
  end

  devise_for :users
  root to: "posts#index"
  resources :users, only: [:show], as: "profile", :path => "u"
  get "about" => "home#about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
