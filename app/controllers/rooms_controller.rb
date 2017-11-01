require 'simple-password-gen'

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
		@room = Room.new(room_params.merge(:password=>pwd, :roomcode=>code))
			
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
			return [*('A'..'Z')].sample(4).join
		end
end
