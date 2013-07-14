Presale::Application.routes.draw do
  resources :stores

  resources :products

  devise_for :users, controllers: { sessions: 'sessions' }

  root 'products#index'
end
