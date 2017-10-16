require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
	describe "POST #create" do
		before(:all) do
			Room.create(name: "a good room i guess", password: "passwords") 
			@id = Room.last.id
		end
		it 'puts a question in a room' do
			post :create, :params => {:question => {:body => "a question"}, :room_id => @id}
			expect(response).to redirect_to '/rooms/' + @id.to_s
		end
	end
end
