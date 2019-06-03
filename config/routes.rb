Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: "users/omniauth_callbacks" }
  as :user do
    get 'users', to: 'devise/registrations#new', as: :users
  end
  get 'home/index'
  root "home#index"

  resources :posts, :comments

  resources :users, only: [:new, :create, :show, :edit, :update, :destroy]

  get 'guest_index', to: 'home#guest_index', as: :guest_index
  get 'legal', to: 'home#legal', as: :legal

  get 'admin_tools', to: 'admin_tools#user_tools', as: :admin_tools
  get 'dumpster', to: 'admin_tools#dumpster', as: :dumpster

  get 'profile/:id', to: 'profiles#show', defaults: { history: 'all' }, as: :profile
  post 'profile/:id', to: 'profiles#update', as: :profile_update
  get 'profile/:id', to: 'profiles#show_created', as: :profile_created
  get 'search', to: 'searches#index', as: :search
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
