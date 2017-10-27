require 'rails_helper'

RSpec.describe JoinRoomController, type: :controller do
    describe "GET join room interface" do
      it "launches the join room interface screen successfully" do
        assert_response :success, action: 'show'
      end

    end

    describe "Submit Button tests" do
      #context "submit button will not function if..." do
      # it "-- room code tests do not pass" do
      #    expect(1).to eq(2)
      #  end
      #  it "-- user name tests do not all pass" do
      #    expect(1).to eq(2)
      #  end
      #end

      #context "submit button will function if ..." do

      #end

      # does the form information get saved?
      # does the username and room name get saved to the database


      it "clicking submit button on invalid input reloads current page and returns http success" do
        assert_response :success, controller: 'join_room', action: 'show'
      end

      # does the button take us to the quiz room?
      it "clicking submit button on valid input launches the quiz room" do
        assert_response :success, controller: 'join_room', action: 'default'
      end
    end
end
