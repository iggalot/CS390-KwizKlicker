require 'rails_helper'

feature "Add answers to a question" do
	scenario "Teacher makes a room and a question and then adds an answer" do
		@room = Room.create(name: "sonic", password: "Never", roomcode: "BBQE")
		visit '/rooms/' + @room.id.to_s
		fill_in "password", :with => "Never"
		find('input[type=submit]').click

		fill_in 'question[body]', :with=> "Android or IOS"
		find('input[type=submit]').click

		expect(page).to have_text('Android or IOS')

		expect{
		fill_in 'answer[text]', :with => 'Android!'
		click_on('Create Answer')
		}.to change{Answer.all.count}.by(1)
		fill_in 'answer[text]', :with => 'IOS!'
		click_on('Create Answer')
		expect(page).to have_text('IOS!')
	end
end
