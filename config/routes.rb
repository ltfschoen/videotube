Rails.application.routes.draw do

  root to: 'pages#index'
  
  get '/pages/index', to: 'pages#index'

  get '/pages/about', to: 'pages#about'

  get '/pages/contact', to: 'contacts#new'

  get "/contacts" => redirect("/contacts/new")
  resources 'contacts', only: [:new, :create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
