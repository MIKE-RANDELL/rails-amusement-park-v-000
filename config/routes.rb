Rails.application.routes.draw do

  resources :rides

  resources :attractions

root 'users#home'

resources :users
resources :sessions

get '/signin' => 'sessions#new'

end
