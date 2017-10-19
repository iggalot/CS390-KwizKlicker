class QuestionsController < ApplicationController

	def edit
		@question = Question.find(params[:id])
	end


	def create
		@room = Room.find(params[:room_id])
		@question = @room.questions.create(question_params)
		redirect_to room_path(@room)
	end


	def update
		@question = Question.find(params[:id])
	
		if @question.update
			redirect_to @question
		else
			render 'edit'
		end
	end

	def show
		@question = Question.find(params[:id])
		@room = Room.find(@question.room_id)
		render 'show'
	end


	def destroy
		@room = Room.find(params[:room_id])
		@question = @room.questions.find(params[:id])
		@question.destroy
		redirect_to room_path(@room)
	end



	private
		def question_params
			params.require(:question).permit(:body)
		end
end
