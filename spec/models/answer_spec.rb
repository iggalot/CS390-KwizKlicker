require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
	before(:all) do
		@room = Room.create(name: "Answer testing room", password: "Alphanumeric", roomcode: "rffr")
		@question = Question.create(room_id: @room.id, body: "Does rails work?")


	end
	describe "Answers belong to question." do
		it 'make a new answer' do
		expect{
			@answer = Answer.create(question_id: @question.id, text: "No")
			}.to change{@question.answers.count}.by(1)
		end		
	end


	describe "Make sure answers are actually made" do
		it "Loops through each answer and make sure its not Nil" do
			@answer=Answer.create(question_id: @question.id, text: "Sure")
			expect(@answer.id).not_to be_nil
		end
	end


	describe "If an answer has no body, don't let it be created" do
		it "Makes an answer with an empty string for a body, then check if the id is nil" do
			@answer = Answer.create(question_id: @question.id, text: "")
			expect(@answer.id).to be_nil
		end
	end



	describe "You can delete an answer" do
		it "Delete an answer and check that its gone" do
		@answer=Answer.create(question_id: @question.id, text: "Yes")
		expect{
			@answer.destroy
			}.to change{@question.answers.count}.by(-1)
		end
	end




	describe "If you delete a room, then the answers of said room should all be deleted" do
	it "Makes a new room, then a question of that room, then an answer. delete the room, see if answer count changes" do
			@delroom = Room.create(name: "To be deleted", password: "Deleting", roomcode: "ffrr")
			@delquestion = Question.create(room_id: @delroom.id, body: "I don't exist!")
			@answer = Answer.create(question_id: @delquestion.id, text: "Neither do I!")
			expect{
				@delroom.destroy
			}.to change{Answer.all.count}.by(-1)
		end
	end

	describe "If you delete a question, then the answers of the question should be deleted" do
		it "Make a question of a room, make an answer, call delete on the question, then see if the answer count changes" do
			@delroom = Room.create(name: "Exists soley for testing", password: "questioning", roomcode: "lead")
			@delquestion=Question.create(room_id: @delroom.id, body: "I will die")
			@delanswer = Answer.create(question_id: @delquestion.id, text: "Death to me")
			expect{
				@delquestion.destroy
			}.to change{Answer.all.count}.by(-1)
		end
	end
end
