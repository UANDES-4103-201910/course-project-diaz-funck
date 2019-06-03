Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: "users/omniauth_callbacks" }
  as :user do
    get 'users', to: 'devise/registrations#new', as: :users
  end
  as :post do
    get 'posts', to: 'posts#new', as: :posts
    get 'upvote', to: 'posts#upvote', as: :upvote
    get 'downvote', to: 'posts#downvote', as: :downvote
  end
  get 'home/index'
  root "home#index"

  resources :comments

  resources :users, :posts, only: [:new, :create, :show, :edit, :update, :destroy]

  get 'guest_index', to: 'home#guest_index', as: :guest_index
  get 'legal', to: 'home#legal', as: :legal

  get 'admin_tools', to: 'admin_tools#user_tools', as: :admin_tools
  get 'dumpster', to: 'admin_tools#dumpster', as: :dumpster

  get 'profile/:id', to: 'profiles#show', defaults: { history: 'all' }, as: :profile
  get 'profile/:id', to: 'profiles#show_created', as: :profile_created
  get 'search', to: 'searches#index', as: :search
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
