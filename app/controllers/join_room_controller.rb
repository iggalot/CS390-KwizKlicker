class JoinRoomController < ApplicationController
  def show
    # @join_room = join_room_url.find(params[:id])

    # render 'show'
  end

  def create
    @info = StudentInfo.new(join_room_params)
    @info.save
    redirect_to @info
  end

  private
  def join_room_params
    params.require(:join_room).permit(:name, :room)
  end
end
