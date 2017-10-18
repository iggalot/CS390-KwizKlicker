Rails.application.routes.draw do
  get 'lobby/index'
  resources :rooms
  root 'lobby#index'
  resources :rooms do
  	resources :questions do
		resources :answers
	end
  end
  scope '/rooms' do
  	post '/auth' => 'rooms#auth'
  end


    resources :join_room

end
