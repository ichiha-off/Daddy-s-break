Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

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

	get 'users/:id/quit' => 'users#quit'
	patch 'users/:id/quit_update' => 'users#quit_update'
	resources :users, only: [:show, :edit, :update] do
		resource :relationships, only: [:create, :destroy]
		get 'follows' => 'relationships#following', as: 'follows'
    get 'followers' => 'relationships#followed', as: 'followers'
	end

	get 'topics/ranking_index' => 'topics#ranking_index' 
	resources :topics do
		resources :comments, only: [:show, :create, :destroy] do
			resource :favorites, only: [:create, :destroy]
			resources :replies, only: [:create, :destroy]
		end
	end

	resources :notifications, only: [:index]

	namespace :admins do
		resources :categories, only: [:index, :create, :edit, :update]
	end

end
