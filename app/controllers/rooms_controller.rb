require 'simple-password-gen'

class RoomsController < ApplicationController
  def new
    @room = Room.new
  end

  def get_quiz_question
    @room = Room.find(params[:id])
    @question = @room.questions[params[:question_id].to_i - 1]

    render 'quiz_question'
  end

  def remote
    @room = Room.find(params[:id])
    @room.state = "active"

    if @room.save

      render 'remote'
    end
  end

  def post_quiz_question
    @room = Room.find(params[:id])

    unless session.has_key? :username
      redirect_to '/rooms/quiz/' + @room.id.to_s
      return
    end

    @question = @room.questions[params[:question_id].to_i - 1]
    @res = Response.create(question_id: @question.id, answeridx: params[:response].to_i, username: session[:username])

    redirect_to '/rooms/quiz/' + @room.id.to_s
  end

  def quiz
    @room = Room.find(params[:id])
    @username = session[:username]

    # find most recent response
    @last_res = Response.order("created_at DESC").find_by_username(@username)
    @has_res = @last_res.present?

    if @has_res
      @last_res_text = Question.find_by_id(@last_res.question_id).answers[@last_res.answeridx].text
    end

    render 'quiz'
  end

  def show
    @room = Room.find(params[:id])

    if authed?
      render 'show'
    else
      render 'unauthed'
    end
  end

  def destroy
    @room = Room.find(params[:id])
    session[:rooms].delete(@room.id)
    @room.destroy

    redirect_to '/'
  end

  def authed?
    unless session.has_key? :rooms
      return false
    end

    return session[:rooms].include? params[:id].to_i
  end

  def auth
    @room = Room.find(params[:id])
    if params[:password] == @room.password
      if not session.has_key?(:rooms)
        session[:rooms] = []
      end
      session[:rooms].push(@room.id.to_i)
      redirect_to @room
    else
      flash[:auth] = "Wrong password"
      render 'unauthed'
    end
  end

  def create
    pwd = Password.pronounceable 8
    code = generate_roomcode

    @room = Room.new(room_params.merge(:password => pwd, :roomcode => code))

    if @room.save
      if not session.has_key?(:rooms)
        session[:rooms] = []
      end

      session[:rooms].push(@room.id)
      redirect_to @room
    else
      render 'new'
    end
  end

  private
  def room_params
    params.require(:room).permit(:name)
  end

  def generate_roomcode
    @code = [*('A'..'Z')].sample(4).join
    while (Room.find_by_roomcode (@code).present?)
      @code = [*('A'..'Z')].sample(4).join
    end

    return @code

  end
end
