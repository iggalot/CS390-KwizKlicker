require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
	describe 'POST #create' do
		it 'makes a new room and redirects to it' do
			post :create, params: {:room => {:name => 'test room more chars'}}
			expect(response).to redirect_to '/rooms/' + Room.last.id

			post :create, params: {:room => {:name => 'test room more chars'}}
			expect(response).to redirect_to '/rooms/' + Room.last.id
		end
	end
end
