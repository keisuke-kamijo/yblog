# frozen_string_literal: true

Rails.application.routes.draw do
  get '/signup', to: 'users#new'
  get '/users/:id/articles', to: 'users#articles'
  resources :users
  resources :articles
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
