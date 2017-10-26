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

  #scope '/join_room' do
   # post 'show' => 'join_room#show'
    #get 'show' => 'join_room#show'
    #path 'join_room_path' =>
  #end
  resources :join_room
  scope '/join_room' do
   post 'show' => 'join_room#create'
    end
end
