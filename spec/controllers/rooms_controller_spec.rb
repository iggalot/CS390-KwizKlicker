require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
	describe 'POST #create' do
		it 'makes a new room and redirects to it' do
      expect {
				post :create, params: {:room => {:name => 'test room more chars'}}
				expect(response).to redirect_to '/rooms/' + Room.last.id.to_s

				post :create, params: {:room => {:name => 'test room more chars'}}
				expect(response).to redirect_to '/rooms/' + Room.last.id.to_s
      }.to change{Room.all.count}.by(2)
		end
  end

	pending "launches the create room interface screen"
	pending "creates a room entry in the database"
	pending "creates a unique room identifier"
	pending "doesnt allow duplicate rooms to exist"
	pending "asks for teacher id?"
	pending "verifies teacher id is unique in database"
	pending "verifies that a teacher isn't already assigned to a room"
	pending "enters valid room identifier label?"
end
