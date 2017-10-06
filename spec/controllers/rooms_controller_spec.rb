require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
	describe 'POST #create' do
		it 'makes a new room and redirects to it' do

			post :create, params: {:room => {:name => 'test room more chars'}}
			expect(response).to redirect_to '/rooms/1'

			post :create, params: {:room => {:name => 'test room more chars'}}
			expect(response).to redirect_to '/rooms/2'
		end
	end
end
