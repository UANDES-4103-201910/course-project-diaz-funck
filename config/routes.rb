Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: "users/omniauth_callbacks" }
  as :user do
    get 'users', to: 'devise/registrations#new', as: :users
  end
  as :post do
    get 'posts', to: 'posts#new', as: :posts
    get 'upvote', to: 'posts#upvote', as: :upvote
    get 'downvote', to: 'posts#downvote', as: :downvote
    get 'follow', to: 'posts#follow', as: :post_follow
    get 'share', to: 'posts#share', as: :post_share
    get 'report', to: 'posts#report', as: :post_report
    get 'delete_comment', to: 'posts#delete_comment', as: :delete_comment
  end
  get 'home/index'
  root "home#index"

  resources :comments

  resources :users, :posts, only: [:new, :create, :show, :edit, :update, :destroy]

  get 'guest_index', to: 'home#guest_index', as: :guest_index
  get 'legal', to: 'home#legal', as: :legal

  get 'admin_tools', to: 'admin_tools#user_tools', as: :admin_tools
  get 'dumpster', to: 'admin_tools#dumpster', as: :dumpster

  get 'profile/:id', to: 'profiles#show', as: :profile
  post 'profile/:id', to: 'profiles#update', as: :profile_update
  get 'profile/:id', to: 'profiles#show_created', as: :profile_created
  get 'search', to: 'searches#index', as: :search
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
