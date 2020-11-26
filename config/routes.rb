Rails.application.routes.draw do
  devise_for :users
  resources :items do
    resources :buyers, only: [:index, :create]
  end
  root to: "items#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
