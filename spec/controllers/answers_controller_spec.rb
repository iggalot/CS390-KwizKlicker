require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
    before(:all) do
        Room.create(name: "testing this room", password: "passwords", roomcode: "aaaA")
        @room_id = Room.last.id
        Question.create(body: "the question here", room_id: @room_id)
        @question = Question.last
        @question_id = Question.last.id
    end

    describe "Teacher makes a question, then adds answers to that question" do
        it 'adds a question' do
            expect {
                post :create, :params => {:answer => {:text => "an answer"}, :room_id => @room_id, :question_id => @question_id }
                expect(response).to redirect_to '/rooms/' + @room_id.to_s + '/questions/' + @question_id.to_s
            }.to change{Answer.all.count}.by(1)
             .and change{@question.answers.count}.by(1)
        end
    end

    describe "Teacher can remove an answer from a question" do
        before {
            @ans = Answer.create(text: "words", question_id: @question_id)
        }
        it "deletes a question" do
            expect {
                delete :destroy, :params => {:id => @ans.id, :room_id => @room_id, :question_id => @question_id}
                expect(response).to redirect_to '/rooms/' + @room_id.to_s + '/questions/' + @question_id.to_s
            }.to change{Answer.all.count}.by(-1)
             .and change{@question.answers.count}.by(-1)
        end
    end
end
