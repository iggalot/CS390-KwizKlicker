require 'simple-password-gen'

class RoomsController < ApplicationController

  def new
    @room = Room.new
  end

  def get_quiz_question
    @room = Room.find(params[:id])
    @question_idx = params[:question_id].to_i;
    @question = @room.questions[params[:question_id].to_i - 1]
    @username = session[:username]

    if @question.nil?
      redirect_to '/rooms/quiz/' + @room.id.to_s + '/finished'
    else
      render 'quiz_question'
    end
  end

  def present
    @room = Room.find(params[:id])

    if not @room.active_question.nil?
      @question_idx = @room.active_question
      @question = @room.questions[@question_idx - 1]
    end

    render 'present'
  end

  def kick
    @room = Room.find(params[:id])
    @user = params[:username]

    StudentInfo.find_by(room_id: @room.id, name: @user).destroy

    redirect_to '/rooms/remote/' + @room.id.to_s
  end


  def finished
    @room = Room.find(params[:id])
    render 'finished'
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

    @res = Response.create(question_id: @question.id,
                           answer_id: @question.answers[params[:response].to_i].id,
                           answeridx: params[:response].to_i,
                           username: session[:username],
                           student_info_id: session[:info_id])

    redirect_to '/rooms/quiz/' + @room.id.to_s
  end

  def next_question
    @room = Room.find(params[:id])

    if @room.active_question.nil?
      @room.active_question = 1
    else
      @room.active_question += 1

      if @room.active_question >= @room.questions.length
        redirect_to '/rooms/quiz/' + @room.id.to_s + '/finished'
        @room.state = "finished"
        @room.save
        return
      end
    end

    @room.save

    redirect_to '/rooms/remote/' + @room.id.to_s
  end

  def reset
    @room = Room.find(params[:id])
    @room.active_question = nil
    @room.state = nil
    @room.save
    @room.student_infos.destroy_all


    redirect_to @room
  end

  def quiz
    @room = Room.find(params[:id])
    @username = session[:username]

    # find most recent response
    @last_res = Response.order("created_at DESC").find_by_username(@username)
    @has_res = @last_res.present?

    # ### it turns out here that @has_res is false.
    if @has_res
      @finished = @last_res.question_id == @room.questions.last.id
    end

    if @has_res
      @last_res_text = Answer.find(@last_res.answer_id).text
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
    #print(@room.id)
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
