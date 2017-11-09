class AnswersController < ApplicationController
	def create
		@question = Question.find(params[:question_id])
		@room = Room.find(@question.room_id)
		@answer = @question.answers.create(answer_params)
		redirect_to room_question_path(@room, @question)
	end


	def destroy
		@question = Question.find(params[:question_id])
		@answer = @question.answers.find(params[:id])
		@room = Room.find(@question.room_id)
		@answer.destroy
		redirect_to room_question_path(@room, @question)
	end



	private
		def answer_params
			params.require(:answer).permit(:text)
		end

end
