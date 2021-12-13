Rails.application.routes.draw do
  root "session#new"
  resources :users
  resources :todos do
    resources :complete
  end
  get "/login_form" => "session#new"
  post "/login" => "session#create"
  delete "/logout" => "session#destroy"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
