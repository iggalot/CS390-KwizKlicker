class RoomsController < ApplicationController
	def new
	end

	def show
		@room = Room.find(params[:id])
	end

	def create
		@room = Room.new(room_params)

		@room.save
		redirect_to @room
	end

	private
		def room_params
			params.require(:room).permit(:name)
		end
end
