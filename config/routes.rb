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
  
  resources :posts do
    resource :vote, module: :posts
    resources :comments, module: :posts do
    end
  end

  devise_for :users #, skip: [:registrations]

  as :user do
    get 'signin' => 'devise/sessions#new'
    post 'signin' => 'devise/sessions#create'
    delete 'signout' => 'devise/sessions#destroy'
  end

 
  #root to: "home#invite"
  root to: "posts#index"


  resources :users, only: [:show], as: "profile", :path => "u"
  get "about" => "home#about"
  get "live" => "posts#index"
  get "invite" => "home#invite"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
