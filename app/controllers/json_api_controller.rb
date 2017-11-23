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

  def responses
    @qid = params[:question_id]
    render json: Response.where(question_id: @qid).to_json
  end

  def infos
    @room_id = params[:room_id]
    render json: StudentInfo.where(room_id: @room_id).to_json
  end
end
