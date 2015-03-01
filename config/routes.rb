Rails.application.routes.draw do
  root 'welcome#index'
  resources :tasks
  resources :users
  resources :projects

   get '/terms' => 'terms#index'
   get '/about' => 'about#index'
   get '/faq' => 'common_questions#index'
   #get '/tasks' => 'tasks#index'
   get '/sig-up', to: 'registrations#new'
   post '/sign-up', to: 'registrations#create'
   get '/sig-in', to: 'authentication#new'
   post '/sign-in', to: 'authentication#create'
   get '/sign-out', to: 'authentication#destroy'
 end
