class AnswersController < ApplicationController
	def create
		@question = Question.find(params[:question_id])
		@room = Room.find(@question.room_id)
		@answer = @question.answers.create(answer_params)
		redirect_to room_question_path(@room, @question)
	end

	def timer
		e= Time.now + 30
		while Time.now<= e
			sleep 1
			t= e-time.now
			sec= t%60
			print "\b" *5
			if t>0
				printf "%02d", sec

			else
				redirect_to :controller => "Answers_percentage", :action => :new
			end
		end
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
