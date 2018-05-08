Rails.application.routes.draw do
    devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "homes#index"
  resources :todos
  resources :homes
    
  namespace :api do
    namespace :v4 do
      resources :todos,  defaults: {format: 'json'} 
    end
  end
end
