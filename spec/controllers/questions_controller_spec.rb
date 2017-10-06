require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
	describe "POST #create" do
		before { Room.create(name: "a good room i guess") }

		it 'puts a question in a room' do
			post :create, :params => {:question => {:body => "a question"}, :room_id => 1}
			expect(response).to redirect_to '/rooms/1'
		end
	end
end
