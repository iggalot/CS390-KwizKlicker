require 'rails_helper'

RSpec.describe JoinRoomController, type: :controller do
    describe "GET join room interface" do
      it "launches the join room interface screen successfully" do
        assert_response :success, action: 'show'
      end

    end

    describe "Submit Button tests" do
      # CREATE writes to StudentInfo table successfully
      # Does not allow duplicate name / room combo in same room?
      # Requires that the room exists in the Rooms database
      # Returns to SHOW page if room does not already exists
      # --- show error message
      # Returns to SHOW if user name is invalid
      # --- show error message

      # Jumping directly to a specific




      it "clicking submit button on invalid input reloads current page and returns http success" do
        assert_response :success, controller: 'join_room', action: 'show'
      end

      # Upon successful submit CREATE redirects to DEFAULT page
      # does the button take us to the quiz room?
      it "clicking submit button on valid input launches the quiz room" do
        assert_response :success, controller: 'join_room', action: 'default'
      end
    end
end
