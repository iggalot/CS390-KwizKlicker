Rails.application.routes.draw do
  get 'lobby/index'
  resources :rooms
  root 'lobby#index'
  resources :rooms do
  	resources :questions
  end
end
