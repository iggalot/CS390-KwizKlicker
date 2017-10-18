class AnswersController < ApplicationController






	private
		def answer_params
			params.require(:answer).permit(:text, :representative)

end
