Rails.application.routes.draw do
  get 'home/index'
  root "home#index"
  resources :users, :posts
  get 'guest_index', to: 'home#guest_index', as: :guest_index
  get 'login', to: 'home#login', as: :login
  get 'register', to: 'home#register', as: :register
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
