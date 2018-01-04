Rails.application.routes.draw do

  resources :charges, only: [:create]

  resources :wikis

  devise_for :users

  get 'users/settings' => 'users#edit'

  post 'users/downgrade' => 'users#set_role_standard', as: :downgrade

  get 'about' => 'welcome#about'

  root 'welcome#index'

end
