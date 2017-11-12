class JoinRoomController < ApplicationController
  def show
    #@info = StudentInfo.find(params[:id])

    #render 'show'
  end

  def default

  end


  def create
    @info = StudentInfo.new(join_room_params)
    @infocount = (StudentInfo.where(:name=>@info.name, :room=>@info.room.upcase)).count
    @room = Room.find_by_roomcode(@info.room.upcase)
    #if @infocount.eql?(0)
      if (@room.present? && @info.save)
        session[:username] = @info.name
        session[:romcode] = @info.room.upcase
        redirect_to '/rooms/quiz/' + @room.id.to_s
      #end
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
    @info.find(params[:id])
    @info.destroy
  end

  private
  def join_room_params
    params.require(:join_room).permit(:name, :room)
  end
end
