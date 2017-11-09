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

   scenario "student submits a response" do
        @room = Room.create(name: "Asdf", password: "passw", roomcode: "ABCD")
        @question = Question.create(body: "something", room_id: @room.id)
        Answer.create(text: "an answer of some kind", question_id: @question.id)
        Answer.create(text: "an answer of some kind.", question_id: @question.id)
        Answer.create(text: "an answer of some kind?", question_id: @question.id)
        Answer.create(text: "an answer of some kind...", question_id: @question.id)

        visit '/rooms/quiz/' + @room.id.to_s + '/question/1'
        choose "option0"

        click_button "Submit"

        # We're back on the response page / main quiz page
        expect(page).to have_content("Asdf")

        # It shows what they answered somewhere
        expect(page).to have_content("an answer of some kind")
   end
end
