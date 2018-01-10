Rails.application.routes.draw do

  resources :charges, only: [:create]

  resources :wikis

  resources :wikis, only: [] do
     resources :collaborators, only: [:create, :destroy, :new]
  end

  devise_for :users

  get 'users/settings' => 'users#edit'

  post 'users/downgrade' => 'users#set_role_standard', as: :downgrade

  get 'about' => 'welcome#about'

  root 'welcome#index'

end
