require 'rails_helper'

RSpec.describe StudentInfo, type: :model do
  describe "StudentInfo model instantiation tests" do
    it "has a valid factory" do
      expect(FactoryBot.create(:student_info)).to be_valid
    end
    it "is invalid without a room name" do
      expect(FactoryBot.build(:student_info, room: nil)).to be_invalid
    end
    it "is invalid without a user name" do
      expect(FactoryBot.build(:student_info, name: nil)).to be_invalid
    end

    context "attribute existence tests" do
      newinfo = FactoryBot.create(:student_info, name: "aaaa", room: "cccc") #make a test room for model tests
      it "creates a new room name in StudentInfo model" do
        expect(newinfo).to have_attributes(room: 'cccc')
      end
      it "creates a new username in StudentInfo model" do
        expect(newinfo).to have_attributes(name: 'aaaa')
      end
    end
  end

  describe "Room Code field tests" do
    #was a room code entered?
    it "does not accept a room code field that is blank" do
      expect(StudentInfo.new(:name=>"aaaa", :room=>"")).to be_invalid
    end

    # is it 4 characters long?
    it "accepts room code that is 4 characters long" do
      expect(StudentInfo.new(:name=>"aaaa", :room=>"cccc")).to be_valid
    end
    it "does not accept room code that is less than 4 characters long" do
      expect(StudentInfo.new(:name=>"aaaa", :room=>"c")).to be_invalid
    end

    it "does not accept room code that is more than 4 characters long" do
      expect(StudentInfo.new(:name=>"aaaa", :room=>"ccccccccccccc")).to be_invalid
    end

    # other possible tests to include:
    # ===============================================
    # is the room code valid (in the StudentInfo database)
    # does it exist in the Room database
    # is the correct room id retrieved from the database for a given room code
  end

  describe "Username field tests" do
    # is the room code field blank
    it "does not accept a blank username field" do
      expect(StudentInfo.new(:name=>"", :room=>"cccc")).to be_invalid
    end

    it "accepts a username field that is not blank" do
      expect(StudentInfo.new(:name=>"aaaa", :room=>"cdef")).to be_valid
    end

    # other possible tests to include:
    # =============================================
    # does the username already exist in the room?
    # is the username longer than the minimum length
    # is the username shorter than the maximum length?
  end
end
