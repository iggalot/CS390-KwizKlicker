require 'rails_helper'

RSpec.describe LobbyController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "Click Join" do
		it "returns http success" do
			get :index
			expect(response).to have_http_status(:success)
		end
	pending "launches the join room interface screen"
	pending "The following expextations will all pass"
	pending "Prompts user for a room code"
	pending "Verifies the room code exists"
	pending "Retrieves the room id from the database for a given room code"
	pending "redirects users to room screen"
  end

  describe "Click Create" do
	pending "returns http success for create room screen"
	pending "launches the create room interface screen"
	pending "creates a room entry in the database"
	pending "creates a unique room identifier"
	pending "doesnt allow duplicate rooms to exist"
  	pending "asks for teacher id?"
  	pending "verifies teacher id is unique in database"
	pending "verifies that a teacher isn't already assigned to a room"
	pending "enters valid room identifier label?"
  end
end
