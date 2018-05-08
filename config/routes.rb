Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }


  root "homes#index"
  resources :users do
    resources :todos
  end
  resources :homes
    
  namespace :api do
    namespace :v4 do
      post 'users/log_in' => 'users#log_in'
      resources :users , defaults: {format: 'json'} 
    end
  end
end
