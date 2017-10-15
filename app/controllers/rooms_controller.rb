class RoomsController < ApplicationController
	def new
		@room = Room.new
	end

	def show
		@room = Room.find(params[:id])

		if authed?
			render 'show'
		else
			render 'unauthed'
		end
	end

	def authed?
		return session[:rooms].include? params[:id].to_i
	end

	def create
		@room = Room.new(room_params.merge(:password=>"password123"))
		if not session.has_key?(:rooms)
			session[:rooms] = []
		end

		# TODO better way
		session[:rooms].push(Room.last.id + 1)
			
		if @room.save
			redirect_to @room
		else
			render 'new'
		end
	end

	private
		def room_params
			params.require(:room).permit(:name)
		end
end
