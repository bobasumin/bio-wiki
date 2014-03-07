BioWiki::Application.routes.draw do

  resources :collaborations, only: [:index]

  devise_for :users

  resources :wikis do
    resources :sections do
      resources :votes 
    end
  end

  resources :subscriptions

  resources :friendships
  
  match "about" => "welcome#about", via: :get

  authenticated :user do
    root to: 'wikis#index', as: :authenticated_root
  end 

  root to: 'welcome#index'
end
