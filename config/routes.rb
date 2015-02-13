Rails.application.routes.draw do
  root 'welcome#index'
  resources :tasks
  resources :users

   get '/terms' => 'terms#index'
   get '/about' => 'about#index'
   get '/faq' => 'common_questions#index'
   #get '/tasks' => 'tasks#index'

 end
