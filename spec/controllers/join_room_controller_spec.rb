require 'rails_helper'

RSpec.describe JoinRoomController, type: :controller do

  describe "Room code tests" do
  #was a room code entered?
    it "get a room code" do
    #render_views.should have_selector("input", :type => "text", :name => "student[name]", :value => "" )
    end
  #is the room code valid
  #does it exist
  #is it 4 characters long
  #is the room open???
    end

  describe "Username tests" do


  #was a username entered
  #is the username taken in the room?
  #test min length
  #max length 6-20?
    end

  describe "Submit tests" do

  #does the button take us to the quiz
  #does the username get saved
  end

  pending "launches the join room interface screen"
  pending "The following expextations will all pass"
  pending "Prompts user for a room code"
  pending "Verifies the room code exists"
  pending "Retrieves the room id from the database for a given room code"
  pending "redirects users to room screen"

end
