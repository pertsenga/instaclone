Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end

  resources :profiles, only: [:index, :show]
  post '/profiles/:id/send_request', to: 'profiles#send_request', as: :send_request
  post '/friendships/:id/accept', to: 'profiles#accept_request', as: :accept_request
  post '/friendships/:id/decline', to: 'profiles#decline_request', as: :decline_request

  resources :photos, only: [:index, :show, :new, :create, :destroy]

  resources :comments, only: [:create, :edit, :update, :destroy]

  root 'photos#index'

  get '*path', to: 'photos#index', constraints: lambda { |req| req.path.exclude? 'rails/active_storage' }
end
