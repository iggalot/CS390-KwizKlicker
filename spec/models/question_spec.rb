require 'rails_helper'

RSpec.describe Question, type: :model do

	describe "Questions are properly created" do
		it "If a question has no body, throw a fit" do
			@room = Room.create(name: "Temporary", password: "2R4U", roomcode: "LLLL")
			@question = Question.create(room_id: @room.id, body: "")
			expect(@question.id).to be_nil
		end
	end





	describe "It is possible to delete a question" do
		it "Makes a room, and then a question, and tries to delete the question" do
			@room = Room.create(name: "Temporary", password: "2R4U", roomcode: "tttt")
			@question = Question.create(room_id: @room.id, body: "Deleting")
			expect{
					@question.destroy
				}.to change{Question.all.count}.by(-1)
		end
	end


	describe "If a room is deleted, delete all questions attatched." do
		it "Makes a room, and then a question. Delete the room, then see if question count changes" do

		@room = Room.create(name: "Delete testing", password: "R24U", roomcode: "rffr")
		@question = Question.create(room_id: @room.id, body: "Will this delete?")

		expect{
			@room.destroy
		}.to change{Question.all.count}.by(-1)
		end
	end

end
