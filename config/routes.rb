Rails.application.routes.draw do 
  devise_for :users
  #get 'home/index'
  #get 'users/index'
  resources :users, only: [:index, :edit, :update, :destroy] do 
    #collection do
      post 'import', on: :collection
    #end
  end

  root to: "users#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end