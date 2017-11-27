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
    get '/quiz/:id' => 'rooms#quiz'
    get '/quiz/:id/question/:question_id' => 'rooms#get_quiz_question'
    post '/quiz/:id/question/:question_id' => 'rooms#post_quiz_question'
    get '/remote/:id/next' => 'rooms#next_question'
    get '/remote/:id' => 'rooms#remote'
    get '/reset/:id' => 'rooms#reset'
  end

  get '/api/active/:id' => 'json_api#active'

  resources :join_room
  scope '/join_room' do
    post 'show' => 'join_room#create'
    get 'show' => 'join_room#show'
  end

  resources :graphics

  #for the action cable web socket stuff
  mount ActionCable.server, at: '/cable'
end
