require 'rails_helper'


feature "Create a question" do
	scenario "Teacher goes to a new room, makes a question, then verifies its existence" do
	@room = Room.create(name: "Ryleh", password: "heya", roomcode: "RRYG")
	visit '/rooms/' + @room.id.to_s
	fill_in "password", :with => "heya"
	find('input[type=submit]').click
	
	fill_in 'question[body]', :with => "There is a password"
	expect{
		find('input[type=submit]').click
	}.to change{@room.questions.all.count}.by(1)

	expect(page).to have_text ('There is a password')
	click_on('Back')

	expect(page).to have_text('Ryleh') #make sure we're back at the room page

	end
end

feature "Delete a question" do
	scenario "Create a question, then try to delete it" do
		@room = Room.create(name: "Ederal", password: "cthulhu", roomcode: "YRHN")
		visit '/rooms/' + @room.id.to_s
		fill_in 'password', :with=> 'cthulhu'
		find('input[type=submit]').click
		fill_in 'question[body]', :with => "Hello"
		find('input[type=submit]').click
		click_on('Back')
		expect{
			click_on('Delete Question')
			}.to change{@room.questions.all.count}.by(-1)
	end
end
