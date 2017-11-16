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
      expect(@room.student_infos.create(:name=>"aaaa", :roomcode=>"")).to be_invalid
      @room.destroy
    end

    # is it 4 characters long?
    it "accepts room code that is 4 characters long" do
      @room = Room.create(:name=>"lsdjf", :password=>"lkdf", :roomcode=>"CCCC")
      @student = @room.student_infos.create(:name=>"aaaa", :roomcode=>"CCCC")
      expect(@student).to be_valid
      #expect(StudentInfo.new(:name=>"aaaa", :roomcode=>"CCCC")).to be_valid
      @room.destroy
    end
    it "does not accept room code that is less than 4 characters long" do
      @room = Room.create(:name=>"lsdjf", :password=>"lkdf", :roomcode=>"CCCC")
      expect(@room.student_infos.create(:name=>"aaaa", :roomcode=>"c")).to be_invalid
      @room.destroy
    end

    it "does not accept room code that is more than 4 characters long" do
      @room = Room.create(:name=>"lsdjf", :password=>"lkdf", :roomcode=>"CCCC")
      expect(@room.student_infos.create(:name=>"aaaa", :roomcode=>"ccccccccccccc")).to be_invalid
      @room.destroy
    end

    it "accepts room code that is 4 letters" do
      @room = Room.create(:name=>"lsdjf", :password=>"lkdf", :roomcode=>"CCCC")
      expect(@room.student_infos.create(:name=>"aaaa", :roomcode=>"c3cc")).to be_invalid
      @room.destroy
    end
    it "roomcode converted to uppercase letters" do
      @room = Room.create(:name=>"test", :password=>"password", :roomcode=>"AAAA")
      @info = @room.student_infos.create(:name => "test", :roomcode => "aaaa")
      expect(@info.roomcode).to eq ("AAAA")
      @room.destroy
    end
    it "does not accept room code that is 4 special characters" do
      @room = Room.create(:name=>"lsdjf", :password=>"lkdf", :roomcode=>"CCCC")
      expect(@room.student_infos.create(:name=>"aaaa", :roomcode=>"!@$%")).to be_invalid
      @room.destroy
    end
    it "accept room code that is 4 capital letter" do
      @room = Room.create(:name=>"lsdjf", :password=>"lkdf", :roomcode=>"CCCC")
      expect(@room.student_infos.create(:name=>"aaaa", :roomcode=>"ASDF")).to be_valid
      @room.destroy
    end

    # other possible tests to include:
    # ===============================================
    # is the room code valid (in the StudentInfo database)
    context "Testing database lookups"  do

      it "accepts a roomcode that exists in the rooms database" do
        @room1 = Room.create(:name=>"test", :password=>"password", :roomcode=>"AAAA")
        @info1 = @room1.student_infos.create(:name=>"student", :roomcode=>"AAAA")


        expect(Room.find_by_roomcode(@info1.roomcode)).to be_valid
        @room1.destroy
      end
      it "does not accept a roomcode that doesn't exists in the rooms database" do
        @room1 = Room.create(:name=>"test", :password=>"password", :roomcode=>"AAAA")
        @info1 = @room1.student_infos.create(:name=>"student", :roomcode=>"QWER")
        expect(StudentInfo.find_by_roomcode("ABCD")).to be_nil
        @room1.destroy
      end

    end



    # is the correct room id retrieved from the database for a given room code

  end

  describe "Username field tests" do
    # is the room code field blank
    it "does not accept a blank username field" do
      @room = Room.create(:name=>"test", :password=>"password", :roomcode=>"AAAA")
      expect(@room.student_infos.create(:name=>"", :roomcode=>"AAAA")).to be_invalid
      @room.destroy
    end

    it "accepts a username field that is not blank" do
      @room = Room.create(:name=>"test", :password=>"password", :roomcode=>"AAAA")
      expect(@room.student_infos.create(:name=>"aaaa", :roomcode=>"AAAA")).to be_valid
      @room.destroy
    end

    it "accepts 2 different usernames in the same room" do
      @room = Room.create(:name=>"test", :password=>"password", :roomcode=>"CDEF")
      @student = @room.student_infos.create(:name=>"name1", :roomcode=>"cdef")
      @student2 = @room.student_infos.create(:name=>"name2", :roomcode=>"cdef")
      expect(@student).to be_valid
      expect(@student2).to be_valid
      @room.destroy
    end
    it "does not accept 2 usernames that are the same in the same room" do
      @room = Room.create(:name=>"test", :password=>"password", :roomcode=>"CDEF")
      @student = @room.student_infos.create(:name=>"name1", :roomcode=>"cdef")
      @student2 = @room.student_infos.create(:name=>"name1", :roomcode=>"cdef")
      expect(@student).to_not be_valid
      expect(@student2).to be_invalid
      @room.destroy
    end
    it "accepts 2 different usernames in different rooms" do
      @room = Room.create(:name=>"test", :password=>"password", :roomcode=>"CDEF")
      @room1 = Room.create(:name=>"test", :password=>"password", :roomcode=>"CDBN")
      @student = @room.student_infos.create(:name=>"name1", :roomcode=>"cdef")
      @student2 = @room1.student_infos.create(:name=>"name2", :roomcode=>"cdbn")
      expect(@student).to be_valid
      expect(@student2).to be_valid
      @room.destroy
      @room1.destroy
    end
    it "accepts 2 usernames that are the same in different rooms" do
      @room = Room.create(:name=>"test", :password=>"password", :roomcode=>"CDEF")
      @room1 = Room.create(:name=>"test", :password=>"password", :roomcode=>"CDBN")
      @student = @room.student_infos.create(:name=>"name1", :roomcode=>"cdef")
      @student2 = @room1.student_infos.create(:name=>"name1", :roomcode=>"cdbn")
      expect(@student).to be_valid
      expect(@student2).to be_valid
      @room.destroy
      @room1.destroy
    end
    # other possible tests to include:
    # =============================================
    # is the username longer than the minimum length
    # is the username shorter than the maximum length?
  end

  context "Deletion Tests" do
    it "destroys info without destroying room" do
      @room = Room.create(:name=>"test", :password=>"password", :roomcode=>"CDEF")
      @student = @room.student_infos.create(:name=>"name1", :roomcode=>"cdef")

      @student.destroy

      expect(@room).to be_valid
      expect(@student).to be_invalid
    end

    it "destroys info when destroying room" do
      @room = Room.create(:name=>"test", :password=>"password", :roomcode=>"CDEF")
      @student = @room.student_infos.create(:name=>"name1", :roomcode=>"cdef")

      @room.destroy
      #@student.destroy

      expect(@room).to be_invalid
      expect(@student).to be_invalid
    end
  end

end
