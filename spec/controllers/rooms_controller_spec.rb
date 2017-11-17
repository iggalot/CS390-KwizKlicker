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
  
end
