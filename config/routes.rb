# frozen_string_literal: true

Rails.application.routes.draw do
  root 'sessions#new'
  get '/signup', to: 'users#new'
  get '/users/:id/articles', to: 'users#articles'
  post '/users/:id/articles', to: 'articles#insert'
  get '/users/:id/lists', to: 'users#lists'
  resources :users
  resources :articles
  resources :lists
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  delete '/assignments/:list_id/:article_id', to: 'articles#eject'
end
