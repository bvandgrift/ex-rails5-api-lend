Rails.application.routes.draw do
  resources :books, only: [:index, :show]
  resources :sections, only: [:index, :show] do
    resources :titles, only: [:index]
  end
  resources :titles, only: [:index, :show, :create]
  resources :authors, only: [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
