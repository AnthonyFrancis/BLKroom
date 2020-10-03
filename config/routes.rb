Rails.application.routes.draw do
  resources :rooms


  resources :posts do
    member do 
      put "vote", to: "posts#vote"
    end 
    
  end 

  devise_for :users
  root to: "posts#index"
  resources :users, only: [:show], as: "profile"
  get "about" => "home#about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
