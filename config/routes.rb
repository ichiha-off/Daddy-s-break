Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'homes#about'
  get 'user/topics/index' => 'users#user_topics'
  get 'search' => 'searches#search'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    sessions: 'users/sessions'}

  devise_scope :admins do
    devise_for :admins, controllers: {
      registrations: 'admins/registrations',
      passwords: 'admins/passwords',
      sessions: 'admins/sessions'
    }
  end

  get 'users/quit' => 'users#quit'
  patch 'users/quit_update' => 'users#quit_update'
  resources :users, only: [:show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'follows' => 'relationships#follows', as: 'follows'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  get 'topics/today_ranking' => 'topics#today_ranking'
  get 'topics/weekly_ranking' => 'topics#weekly_ranking' 
  resources :topics do
    resources :comments, only: [:show, :create, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :replies, only: [:create, :destroy]
    end
  end

  delete 'notifications/destroy_all' => 'notifications#destroy_all'
  resources :notifications, only: [:index, :destroy]

  namespace :admins do
    resources :categories, only: [:index, :create, :edit, :update]
  end

end
