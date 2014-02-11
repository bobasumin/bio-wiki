BioWiki::Application.routes.draw do

  devise_for :users

  resources :posts
  resources :subscriptions, except: [:show, :index]

  match "about" => "welcome#about", via: :get

  authenticated :user do
    root to: 'posts#index', as: :authenticated_root
  end 

  root to: 'welcome#index'
end
