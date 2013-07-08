Ariake::Application.routes.draw do
  root to: "top#index"
  resources :users, except: [:index] do
    collection {get "login"}
    member {get "entries"}
  end
  resource :session, only: [:create, :destroy]
  resources :entries do
    collection { get "search", "new_searched", "new_detail"}
    member { post "update_all" }
  end
  resources :maps
  resources :checklists
  resources :orders do
    collection {get "create_from_link"}
    collection {post "update_all"}
  end
  resources :circle_urls, only: [:create, :destroy]
  resources :circles
  resources :handouts, only: [:new, :create, :destroy]
  
  namespace :admin do
    resource :user do
      collection {post "change_permission"}
    end
    resources :executors, only: [:index, :create, :new]
    resources :entries do
      collection { get "search", "new_searched", "new_detail"}
      member { post "update_all" }
    end
  end

end
