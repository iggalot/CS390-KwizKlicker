require 'rails_helper'


feature "Create room" do
  scenario "Teacher creates a room" do
    visit '/'
    click_on "Create Room"
    fill_in "room[name]", :with => "Complex Variables Quiz 1"
    fill_in "room[description]", :with => "Difficult questions about complex variables"
    click_on "Create Room"

    expect(page).to have_content("Complex Variables Quiz 1")
    expect(page).to have_field("input[type=text]")
    expect(page).to have_button("input[name=commit]")
  end
end