Ariake::Application.routes.draw do
  root to: "top#index"
  resources :users, except: [:index] do
    collection {get "login"}
  end
  resource :session, only: [:create, :destroy]
  resources :entries do
    collection { get "search" }
  end
  resources :maps
  resources :checklists
end
