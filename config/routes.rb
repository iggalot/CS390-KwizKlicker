Rails.application.routes.draw do
  get 'lobby/index'

  resources :rooms

  root 'lobby#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
