require 'rails_helper'

RSpec.describe JoinRoomController, type: :controller do
  context "Join Room Controller Tests" do

    describe "GET join room interface" do
      it "launches the join room interface screen successfully" do
        assert_response :success, action: 'show'
      end
    end

    describe "Room Code field tests" do
      #was a room code entered?
      it "gets a room code from the user field" do
        @info1 = StudentInfo.new
        @info1.name = "aaaa"
        @info1.room = "cccc"
        @info2 = StudentInfo.new
        @info2.name = "bbbb"
        @info2.name = "dddd"
        expect(@info1.name).to eq("aaaa")
        expect(@info2.name).not_to eq("aaaa")

        #render_views.should have_selector("input", :type => "text", :name => "student[name]", :value => "" )
      end
      # is the room code field blank
      # is it 4 characters long?
      # is the room code valid (in the database)
      # does the page (error) redirect when the room code is invalid
      # does it exist in the database
      # is the correct room id retrieved from the database for a given room code


      # is the room activated???
    end

    describe "Username tests" do
      # was a username entered
      # is the username blank?
      # does the username already exist in the room?
      # is the username longer than the minimum length
      # is the username shorter than the maximum length?
      #max length 6-20?
    end

    describe "Submit Button tests" do
      # does the button take us to the quiz room?
      # does the form information get saved?
      # does the username and room name get saved to the database
      it "clicking submit button returns http success" do
        assert_response :success, controller: 'join_room', action: 'show'
      end
    end
  end
end
