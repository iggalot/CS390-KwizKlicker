require 'rails_helper'

RSpec.describe Room, type: :model do
  describe "Room model instantiation tests" do
    it "has a valid factory" do
      expect(FactoryBot.create(:room)).to be_valid
    end
    it "is invalid without a room name" do
      expect(FactoryBot.build(:room, name: nil)).to be_invalid
    end
    it "is invalid without a password" do
      expect(FactoryBot.build(:room, password: nil)).to be_invalid
    end
    it "is invalid without a roomcode" do
      expect(FactoryBot.build(:room, roomcode: nil)).to be_invalid
    end

    context "attribute existence tests" do
      newinfo = FactoryBot.create(:room, name: "aaaa", password: "password", roomcode: "cccc") #make a test room for model tests
      it "creates a new room name in Room model" do
        expect(newinfo).to have_attributes(name: 'aaaa')
      end
      it "creates a new username in Room model" do
        expect(newinfo).to have_attributes(password: 'password')
      end
      it "creates a new roomcode in Room model" do
        expect(newinfo).to have_attributes(roomcode: 'cccc')
      end
    end
  end

  describe "Room name field tests" do
    #was a room code entered?
    it "does not accept a room name field that is blank" do
      expect(Room.new(:name=>"", :password=>"password", :roomcode=>"cccc")).to be_invalid
    end
  end

  describe "Roomcode tests" do
    it "does not accept a roomcode that is blank" do
      expect(Room.new(:name=>"", :password=>"password", :roomcode=>"")).to be_invalid
    end
    it "does not accept room code that is more than 4 characters long" do
      expect(Room.new(:name=>"aaaa", :password=>"password", :roomcode=>"ccccccccccccc")).to be_invalid
    end
    it "does not accept room code that is less than 4 characters long" do
      expect(Room.new(:name=>"aaaa", :password=>"password", :roomcode=>"c")).to be_invalid
    end
    it "does not accept room code that includes a number" do
      expect(Room.new(:name=>"aaaa", :password=>"password", :roomcode=>"c2fA")).to be_invalid
    end
    it "does not accept room code that is 4 special characters" do
      expect(Room.new(:name=>"aaaa", :password=>"password", :roomcode=>"!@%$")).to be_invalid
    end
    it "accepts room code is 4 capital letters" do
      expect(Room.new(:name=>"aaaa", :password=>"password", :roomcode=>"AAAA")).to be_valid
    end
    it "does not accept a roomcode that is already taken" do
      @room = Room.create(:name=>"aaaa", :password=>"password", :roomcode=>"AAAA")
      @room2 = Room.create(:name=>"aaaa", :password=>"password", :roomcode=>"AAAA")

      expect(@room).to be_valid
      expect(@room2).to be_invalid

      @room.destroy
    end
    # other possible tests to include:
    # ===============================================
    # is the room code valid (in the StudentInfo database)
    # does it exist in the Room database
    # is the correct room id retrieved from the database for a given room code
  end

  describe "Pasword validation tests" do
    it "does not accept a password that is blank" do
      expect(Room.new(:name=>"", :password=>"", :roomcode=>"cccc")).to be_invalid
    end
    it "does not accept a roomcode that is more than 8 characters" do
      expect(Room.new(:name=>"", :password=>"passwordabc", :roomcode=>"cccc")).to be_invalid
    end
    it "does not accept a roomcode that is less than 8 characters" do
      expect(Room.new(:name=>"", :password=>"p", :roomcode=>"cccc")).to be_invalid
    end

    # other possible tests to include:
    # ===============================================
    # -- invalid chars?
    # -- duplicate passwords in database?  is this allowed?
    # -- duplicate room names in database?

    it "does not accept a roomcode that is already in the database" do
      @test = Room.create(:name=>"test")

      expect(Room.create(:name=>"test2", :password=>"p2", :roomcode=>@test.roomcode)).to be_invalid
    end
  end

  #is room activated
	describe "Rooms can be properly deleted" do
		it "Makes a room and then deletes it" do
			@deleteroom = Room.create(name: "delete me", password: "deletingtime", roomcode: "lptp")
			expect{
				@deleteroom.destroy
			}.to change{Room.all.count}.by(-1)
		end
	end




end
