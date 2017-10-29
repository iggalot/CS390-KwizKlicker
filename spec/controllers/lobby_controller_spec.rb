require 'rails_helper'
require 'capybara/rspec'

RSpec.describe LobbyController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "Click Join" do
		it "returns http success" do
      assert_response :success, controller: 'join_room', action: 'show'
    end
    #it "click join button success" do
      #@result = find("Join Existing Room").find("button").click
			#assert_response :success,
      #click_button "Join Existing Room"
    #end

  end

  describe "Click Create" do
		it "returns http success for create room screen" do
			assert_response :success, controller: 'rooms', action: 'new'
		end

	end
end
