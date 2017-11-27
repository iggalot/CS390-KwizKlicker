class JoinRoomController < ApplicationController
  def show
    #@info = StudentInfo.find(params[:id])

    #render 'show'
  end

  def default

  end


  def create
    temp = StudentInfo.new(join_room_params)

    if (Room.find_by_roomcode(temp.roomcode.upcase).present?)

      @room = Room.find_by_roomcode(temp.roomcode.upcase)
      @info = @room.student_infos.create(join_room_params)
      if (@info.save)
        session[:username] = @info.name
        session[:roomcode] = @info.room

        #announce arrival of users to the quiz room
        ActionCable.server.broadcast 'quizroom_channel',
                                     {content: @info.name + " has joined the room...",
                                     action: 'join_room'}
        redirect_to '/rooms/quiz/' + @room.id.to_s
      end

    else

=begin
      if (@info.name.blank?)
        flash[:name] = "Name can't be blank"
      end

      if (@info.room.blank?)
        flash[:room] = "Roomcode can't be blank"

      else if (@info.room.length != 4)
             flash[:room] = "Roomcode must be 4 letters"
           end
        #else Room.find_by_roomcode(@info.room).nil?
                  #flash[:room] = "Invalid roomcode"

      end
=end
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
