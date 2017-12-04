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
    get '/quiz/:id/finished' => 'rooms#finished'
    get '/present/:id' => 'rooms#present'
    get '/kick/:id/:username' => 'rooms#kick'

    get '/quiz/:id/question/:question_id' => 'rooms#get_quiz_question'
    post '/quiz/:id/question/:question_id' => 'rooms#post_quiz_question'
    get '/remote/:id/next' => 'rooms#next_question'
    get '/remote/:id' => 'rooms#remote'
    get '/reset/:id' => 'rooms#reset'
  end

  get '/api/active/:id' => 'json_api#active'
  get '/api/responses/:question_id' => 'json_api#responses'
  get '/api/student_info/:room_id' => 'json_api#infos'

  resources :join_room
  scope '/join_room' do
    post 'show' => 'join_room#create'
    get 'show' => 'join_room#show'
  end

  #for the action cable web socket stuff
  mount ActionCable.server, at: '/cable'

  get '/:roomcode' => 'rooms#roomglob', constraints: { site_name: /[A-Z]{4}/ }
end
