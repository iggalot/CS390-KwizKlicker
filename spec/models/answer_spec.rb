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
			expect(@answer).not_to be_nil
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


end
