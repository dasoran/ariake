Ariake::Application.routes.draw do
  root to: "top#index"
  resources :entries do
    collection { get "search" }
  end
end
