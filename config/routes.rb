Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'

  resources :rooms do
  	resources :questions
  end
end
