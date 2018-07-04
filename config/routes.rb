Rails.application.routes.draw do
  scope(:path => '/api') do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    post '/login' => 'sessions#create'
    post '/logout' => 'sessions#delete'
    post '/reg' => 'users#create'
    get '/current' => 'users#current'
    resources :users
  end
end
