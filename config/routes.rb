Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  get 'search/search' => 'search#search'

  post '/books/:book_id/favorites' => "favorites#create"
  delete '/books/:book_id/favorites' => "favorites#destroy"

  resources :users,only: [:show,:index,:edit,:update] do
    get 'follower' => 'relationships#follower'
    get 'followed' => 'relationships#followed'
    resource :relationships, only: [:create, :destroy]
  end

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only:[:create, :destroy]
  end
end
