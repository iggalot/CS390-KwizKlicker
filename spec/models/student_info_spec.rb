require 'rails_helper'

RSpec.describe StudentInfo, type: :model do
  describe "StudentInfo model instantiation tests" do
    newinfo = StudentInfo.new(:name=>"aaaa", :room=>"cccc")  #make a test room for model tests
    it "successfully creates a new room name in model" do
      expect(newinfo).to have_attributes(room: 'cccc')
    end
    it "successfully creates a new username name in model" do
      expect(newinfo).to have_attributes(name: 'aaaa')
    end

    #if model parameters are illegal tests here
    # no parameters
    # invalid input
    # blank values
  end

  describe "Room Code field tests" do
    #was a room code entered?
    newinfo = StudentInfo.new

    it "issues a warning if the room field is blank" do
      StudentInfo.new(:name=>"aaaa", :room=>"").invalid?
    end

    # is it 4 characters long?
    it "accepts room code that is 4 characters long" do
      StudentInfo.new(:name=>"aaaa", :room=>"cccc").valid?
    end
    it "does not accepts room code that is less than 4 characters long" do
      StudentInfo.new(:name=>"aaaa", :room=>"c").invalid?
    end

    it "does not accepts room code that is more than 4 characters long" do
      StudentInfo.new(:name=>"aaaa", :room=>"ccccccccccccc").invalid?
    end

    # is the room code valid (in the StudentInfo database)
    # does it exist in the Room database
    # is the correct room id retrieved from the database for a given room code

  end

  describe "Username tests" do
    # is the room code field blank
    it "issues a warning if the username field is blank" do
      StudentInfo.new(:name=>"", :room=>"cccc").valid?
    end

    it "success if the username field is not blank" do
      StudentInfo.new(:name=>"aaaa", :room=>"cdef").valid?
    end

    # does the username already exist in the room?
    # is the username longer than the minimum length
    # is the username shorter than the maximum length?
  end
end
