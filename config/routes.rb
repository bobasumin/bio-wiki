BioWiki::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :types

  resources :posts

  match "about" => "welcome#about", via: :get

  root to: 'welcome#index'
end
