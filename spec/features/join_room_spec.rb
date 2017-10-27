require 'rails_helper'

feature "Join Room" do

  scenario "User attempts to join existing room" do
    visit '/'
    expect(page).to have_content("Lobby")
    click_on "Join Room"
    expect(page).to_not have_content("Lobby")
    expect(page).to have_content("Join Existing Room")

    fill_in "join_room[room]", :with=>"AAAA"
    fill_in "join_room[name]", :with=>"Nethack"

    click_button "Join Room"


  end
end