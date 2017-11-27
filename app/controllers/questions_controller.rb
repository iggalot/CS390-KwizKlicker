class QuestionsController < ApplicationController

  def edit
    @question = Question.find(params[:id])
  end


  def create
    @room = Room.find(params[:room_id])
    @question = Question.new(:body => params['question']['question_body'])
    @answer1 = Answer.new(:text => params['question']['answer_body1'])
    @answer2 = Answer.new(:text => params['question']['answer_body2'])
    @answer3 = Answer.new(:text => params['question']['answer_body3'])
    @answer4 = Answer.new(:text => params['question']['answer_body4'])

    @question.room = @room
    @question.save

    @answer1.question = @question
    @answer1.save

    @answer2.question = @question
    @answer2.save

    @answer3.question = @question
    @answer3.save

    @answer4.question = @question
    @answer4.save

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
