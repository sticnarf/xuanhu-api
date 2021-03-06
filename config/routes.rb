Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  scope(:path => '/api') do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    post '/login' => 'sessions#create'
    post '/logout' => 'sessions#delete'
    post '/reg' => 'users#create'
    get '/current' => 'users#current'
    get '/latest' => 'comments#latest'
    post '/search' => 'courses#search'
    resources :users do
      get 'comments'
      get 'votes'
      post 'upload'
    end
    resources :courses do
      put 'teachers'
      resources :comments do 
        post 'vote'
      end
    end
  end
end
