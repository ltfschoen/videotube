Rails.application.routes.draw do
  root to: 'pages#index'
  
  get '/pages/index', to: 'patients#index'

  get '/pages/about', to: 'patients#about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
