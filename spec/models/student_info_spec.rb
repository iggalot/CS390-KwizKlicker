require 'rails_helper'

RSpec.describe StudentInfo, type: :model do
  # describe "StudentInfo model instantiation tests" do
  #   it "has a valid factory" do
  #     expect(FactoryBot.create(:student_info)).to be_valid
  #   end
  #   it "is invalid without a room name" do
  #     expect(FactoryBot.build(:student_info, roomcode: nil)).to be_invalid
  #   end
  #   it "is invalid without a user name" do
  #     expect(FactoryBot.build(:student_info, name: nil)).to be_invalid
  #   end

  #   context "attribute existence tests" do
  #     @room = Room.create(:name=>"lsdjf", :password=>"lkdf", :roomcode=>"CCCC")
  #     newinfo = FactoryBot.create(:student_info, name: "aaaa", roomcode: "CCCC") #make a test room for model tests
  #     it "creates a new room name in StudentInfo model" do
  #       expect(newinfo).to have_attributes(roomcode: 'CCCC')
  #     end
  #     it "creates a new username in StudentInfo model" do
  #       expect(newinfo).to have_attributes(name: 'aaaa')
  #     end
  #     @room.destroy
  #   end
   #end

  describe "Room Code field tests" do
    #was a room code entered?
    it "does not accept a room code field that is blank" do
      @room = Room.create(:name=>"lsdjf", :password=>"lkdf", :roomcode=>"CCCC")
      expect(StudentInfo.new(:name=>"aaaa", :roomcode=>"")).to be_invalid
      #@room.destroy
    end

    # is it 4 characters long?
    it "accepts room code that is 4 characters long" do
      @room = Room.create(:name=>"lsdjf", :password=>"lkdf", :roomcode=>"CCCC")
      expect(StudentInfo.new(:name=>"aaaa", :roomcode=>"CCCC")).to be_valid
      #@room.destroy
    end
    it "does not accept room code that is less than 4 characters long" do
      @room = Room.create(:name=>"lsdjf", :password=>"lkdf", :roomcode=>"CCCC")
      expect(StudentInfo.new(:name=>"aaaa", :roomcode=>"c")).to be_invalid
      #@room.destroy
    end

    it "does not accept room code that is more than 4 characters long" do
      @room = Room.create(:name=>"lsdjf", :password=>"lkdf", :roomcode=>"CCCC")
      expect(StudentInfo.new(:name=>"aaaa", :roomcode=>"ccccccccccccc")).to be_invalid
      #@room.destroy
    end

    it "accepts room code that is 4 letters" do
      @room = Room.create(:name=>"lsdjf", :password=>"lkdf", :roomcode=>"CCCC")
      expect(StudentInfo.new(:name=>"aaaa", :roomcode=>"c3cc")).to be_invalid
      #@room.destroy
    end
    it "roomcode converted to uppercase letters" do
      @room = Room.create(:name=>"test", :password=>"password", :roomcode=>"AAAA")
      @info = FactoryBot.create(:student_info, :name => "test", :roomcode => "aaaa")
      expect(@info.room).to eq ("AAAA")
      #@info.destroy
    end
    it "does not accept room code that is 4 special characters" do
      @room = Room.create(:name=>"lsdjf", :password=>"lkdf", :roomcode=>"CCCC")
      expect(StudentInfo.new(:name=>"aaaa", :roomcode=>"!@$%")).to be_invalid
      #@room.destroy
    end
    it "accept room code that is 4 capital letter" do
      @room = Room.create(:name=>"lsdjf", :password=>"lkdf", :roomcode=>"CCCC")
      expect(StudentInfo.new(:name=>"aaaa", :roomcode=>"ASDF")).to be_valid
      #@room.destroy
    end

    # other possible tests to include:
    # ===============================================
    # is the room code valid (in the StudentInfo database)
    context "Testing database lookups"  do

      it "accepts a roomcode that exists in the rooms database" do
        @room1 = Room.create(:name=>"test", :password=>"password", :roomcode=>"AAAA")
        @info1 = StudentInfo.create(:name=>"student", :roomcode=>"AAAA")

        expect(Room.find_by_roomcode(@info1.room)).to be_valid
      end
      it "does not accepts a roomcode that doesn't exists in the rooms database" do
        @room1 = Room.create(:name=>"test", :password=>"password", :roomcode=>"AAAA")
        @info1 = StudentInfo.create(:name=>"student", :roomcode=>"QWER")
        expect(StudentInfo.find_by_room("ABCD")).to be_nil
      end

    end



    # is the correct room id retrieved from the database for a given room code

  end

  describe "Username field tests" do
    # is the room code field blank
    it "does not accept a blank username field" do
      expect(StudentInfo.new(:name=>"", :roomcode=>"cccc")).to be_invalid
    end

    it "accepts a username field that is not blank" do
      expect(StudentInfo.new(:name=>"aaaa", :roomcode=>"cdef")).to be_valid
    end

    it "accepts 2 different usernames in the same room" do
      @student = StudentInfo.create(:name=>"name1", :roomcode=>"cdef")
      @student2 = StudentInfo.create(:name=>"name2", :roomcode=>"cdef")
      expect(@student).to be_valid
      expect(@student2).to be_valid
      @student.destroy
      @student2.destroy
    end
    it "does not accept 2 usernames that are the same in the same room" do
      @student = StudentInfo.create(:name=>"name1", :roomcode=>"cdef")
      @student2 = StudentInfo.create(:name=>"name1", :roomcode=>"cdef")
      expect(@student).to_not be_valid
      expect(@student2).to be_invalid
      @student.destroy
      @student2.destroy
    end
    it "accepts 2 different usernames in different rooms" do
      @student = StudentInfo.create(:name=>"name1", :roomcode=>"cdef")
      @student2 = StudentInfo.create(:name=>"name2", :roomcode=>"cdbn")
      expect(@student).to be_valid
      expect(@student2).to be_valid
      @student.destroy
      @student2.destroy
    end
    it "accepts 2 usernames that are the same in different rooms" do
      @student = StudentInfo.create(:name=>"name1", :roomcode=>"cdef")
      @student2 = StudentInfo.create(:name=>"name1", :roomcode=>"cdbn")
      expect(@student).to be_valid
      expect(@student2).to be_valid
      @student.destroy
      @student2.destroy
    end
    # other possible tests to include:
    # =============================================
    # is the username longer than the minimum length
    # is the username shorter than the maximum length?
  end

end
