require 'rails_helper'

feature "Delete room" do

  scenario "Teacher goes to a room and deletes it" do
    @room = Room.create(name: "Asdf II", password: "passw", roomcode: "XYZU")

    visit '/rooms/' + @room.id.to_s

    fill_in "password", :with => "passw"
    find('input[type=submit]').click

    expect(page).to have_selector(".delete_room")

    expect {
      find(".delete_room").click
      expect(page.current_path).to eql('/')
      expect(page).to_not have_content("Asdf II")
    }.to change{Room.all.count}.by(-1)
  end
end
feature "Create room" do

	scenario "Teacher creates a room" do
		visit "/"
		first(:link, 'Create Room').click
		expect(page).to have_text('New Room')
		fill_in('room[name]', :with => 'Yes sir')	
		expect{
			find('input[type=submit]').click
		}.to change{Room.all.count}.by(1)
	end

end
