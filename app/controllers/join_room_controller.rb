class JoinRoomController < ApplicationController
  def show
    # @join_room = join_room_url.find(params[:id])

    # render 'show'
  end

  def default

  end

  def create
    @info = StudentInfo.new(join_room_params)
    if @info.save
      #redirect_to @info
      render 'default'
    else
      if (@info.name.blank?)
        flash[:name] = "Name can't be blank"
      end

      if (@info.room.blank?)
        flash[:room] = "Roomcode can't be blank"

        else if (@info.room.length != 4)
          flash[:room] = "Roomcode must be 4 letters"
          end
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

  private
  def join_room_params
    params.require(:join_room).permit(:name, :room)
  end
end
