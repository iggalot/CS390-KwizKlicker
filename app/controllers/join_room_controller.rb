class JoinRoomController < ApplicationController
  def show
    @info = StudentInfo.new
  end

  def default

  end


  def create


    temp = StudentInfo.new(join_room_params)
    @info = StudentInfo.new(join_room_params)

    if (Room.find_by_roomcode(temp.roomcode.upcase).present?)

      @room = Room.find_by_roomcode(temp.roomcode.upcase)
      @info = @room.student_infos.create(join_room_params)

      if (@info.save)
        session[:info_id] = @info.id
        session[:username] = @info.name
        session[:roomcode] = @info.room

        if @room.active_question.present?
          redirect_to '/rooms/quiz/' + @room.id.to_s + '/question/' + @room.active_question.to_s
        else
          redirect_to '/rooms/quiz/' + @room.id.to_s
        end

      else
        render 'show'
      end

    else
      if(Room.find_by_roomcode(temp.roomcode.upcase).nil?)
        flash[:roomcode] = "Not a Valid Roomcode"
      end

      render 'show'
    end
  end

  def update
    @info = StudentInfo.find(params[:id])

    if @info.update(join_room_params)
      render 'default'
    else
      render 'show'
    end
  end

  def destroy
    @del = Room.find(params[:id])
    @del.destroy
  end

  private
  def join_room_params
    params.require(:join_room).permit(:name, :roomcode)
  end
end
