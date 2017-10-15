require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
	describe "POST #create" do
		before { 
			Room.create(name: "a good room i guess") 
			id = Room.last.id
		}
		it 'puts a question in a room' do
			post :create, :params => {:question => {:body => "a question"}, :room_id => id}
			expect(response).to redirect_to '/rooms/' + id
		end
	end
end
