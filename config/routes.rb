Rails.application.routes.draw do
  resources :users
  resources :todos
  root "home#index"
  get "/login_form" => "session#new"
  post "/login" => "session#create"
  delete "/logout" => "session#destroy"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
