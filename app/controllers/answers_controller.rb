class AnswersController < ApplicationController
	def create
		@question = Question.find(params[:question_id])
		@answer = @question.answers.create(answer_params)
	end



	def destroy
		@question = Question.find(params[:question_id])
		@answer = @question.answer.find(params[:id])
		@answer.destroy
	end



	private
		def answer_params
			params.require(:answer).permit(:text, :representative)
		end

end
