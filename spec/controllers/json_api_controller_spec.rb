require 'rails_helper'

RSpec.describe JsonApiController, type: :controller do
  before(:all) do
    Room.create(name: "a good room i guess", password: "passwords", roomcode: "aaaa")
    @room = Room.last
    @id = Room.last.id
    Question.create(body: "a new question", room_id: @id)
    @question = Question.last
    @question_id = Question.last.id
  end

  describe "Room activity" do
    it "gets if a room is active" do
      get :active, params: {:id => @id}
    end
  end
end
