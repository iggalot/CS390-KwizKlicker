require 'rails_helper'

feature "Take Quiz" do
    scenario "student joins a room before the teacher has started the quiz" do
        @room = Room.create(name: "Asdf", password: "passw", roomcode: "ABCD")

        visit '/'
        expect(page).to have_content("Lobby")
        click_on "Join Room"
        expect(page).to_not have_content("Lobby")
        expect(page).to have_content("Join Existing Room")

        fill_in "join_room[room]", :with => "ABCD"
        fill_in "join_room[name]", :with => "username1"

        click_button "Join Room"

        expect(page).to have_content("Asdf")
   end
end
