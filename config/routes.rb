Rails.application.routes.draw do
  get 'home/index'
  root "home#index"

  resources :users, :posts

  get 'guest_index', to: 'home#guest_index', as: :guest_index
  get 'legal', to: 'home#legal', as: :legal
  get 'login', to: 'home#login', as: :login
  get 'register', to: 'home#register', as: :register

  get 'admin_tools', to: 'admin_tools#user_tools', as: :admin_tools
  get 'dumpster', to: 'admin_tools#dumpster', as: :dumpster

  get 'my_profile', to: 'profiles#my_profile', as: :my_profile
  get 'search', to: 'searches#index', as: :search
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
