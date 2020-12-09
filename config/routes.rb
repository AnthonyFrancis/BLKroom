require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :rooms, :path => "blk" do
    resource :subscriptions
  end

  #get "posts/unsubscribe/:unsubscribe_hash" => "posts#unsubscribe", :as => 'comment_unsubscribe'

  get :search, controller: "application"

  get "posts/unsubscribe/:unsubscribe_hash" => "posts#unsubscribe", :as => 
  "comment_unsubscribe"

  resources :invites
  
  resources :posts do
    resource :vote, module: :posts
    resources :comments, module: :posts do
    end
  end

  devise_for :users
  #root to: "home#invite"
  root to: "posts#index"
  resources :users, only: [:show], as: "profile", :path => "u"
  get "about" => "home#about"
  #get "secretkey=xyz" => "posts#index"
  get "invite" => "home#invite"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
