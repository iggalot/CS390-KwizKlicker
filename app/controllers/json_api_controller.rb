require 'json'

class JsonApiController < ApplicationController
  def active
    @room = Room.find(params[:id])

    if @room
      active = !@room.state.nil?

      render json: {"active": active, "error": 0, "question": @room.active_question.nil? ? -1 : @room.active_question}
    else
      render json: {"error": 1}
    end
  end
end
