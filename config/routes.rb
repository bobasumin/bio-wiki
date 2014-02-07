BioWiki::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :types do
    resources :posts, except: [:index], controller: 'types/posts'
  end

  match "about" => "welcome#about", via: :get

  authenticated :users do
    root to: 'types#index'
  end 

  root to: 'welcome#index'
end
