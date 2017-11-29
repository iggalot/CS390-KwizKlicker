require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
    before(:all) do
        Room.create(name: "a good room i guess", password: "passwords", roomcode: "aaaa")
        @room = Room.last
        @id = Room.last.id
        Question.create(body: "a new question", room_id: @id)
        @question = Question.last
        @question_id = Question.last.id
    end

	describe "POST #create" do
		it 'puts a question in a room' do
            expect {
                post :create, :params => {:question => {:body => "a question"}, :room_id => @id}
                expect(response).to redirect_to '/rooms/' + @id.to_s + '/questions/' + Question.last.id.to_s
            }.to change{Question.all.count}.by(1)
		end
	end

    describe "DELETE a question" do
        it 'deletes a question from the room' do
            expect {
                delete :destroy, :params => {id: @question_id, room_id: @id}
                expect(response).to redirect_to '/rooms/' + @id.to_s
            }.to change{Question.all.count}.by(-1)
             .and change{@room.questions.count}.by(-1)
        end
    end
end
