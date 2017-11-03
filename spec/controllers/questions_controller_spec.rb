require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
	describe "POST #create" do
		before(:all) do
			Room.create(name: "a good room i guess", password: "passwords", roomcode: "aaaa")
			@id = Room.last.id
		end
		it 'puts a question in a room' do
            expect {
                post :create, :params => {:question => {:body => "a question"}, :room_id => @id}
                expect(response).to redirect_to '/rooms/' + @id.to_s
            }.to change{Question.all.count}.by(1)
		end
	end
end
