BioWiki::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  match "about" => "welcome#about", via: :get

  root to: 'welcome#index'
end
