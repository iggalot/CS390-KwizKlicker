require 'rails_helper'

feature "Take Quiz" do
  def join_with_name(room, name)
    visit '/'
    expect(page).to have_content("Lobby")
    click_on "Join Room"
    expect(page).to_not have_content("Lobby")
    expect(page).to have_content("Join Existing Room")

    fill_in "join_room[roomcode]", :with => room
    fill_in "join_room[name]", :with => name

    click_button "Join Room"
  end

  scenario "student joins a room (logs in with code) before the teacher has started the quiz" do
    @room = Room.create(name: "Asdf", password: "passw", roomcode: "ABCD")

    join_with_name("ABCD", "username1");

    expect(page).to have_content("Asdf")

    # Should know their username
    expect(page).to have_content("username1")
  end

  scenario "student submits a response" do
    @room = Room.create(name: "Asdf", password: "passw", roomcode: "ABCD")
    @question = Question.create(body: "something", room_id: @room.id)
    Answer.create(text: "an answer of some kind", question_id: @question.id)
    Answer.create(text: "an answer of some kind.", question_id: @question.id)
    Answer.create(text: "an answer of some kind?", question_id: @question.id)
    Answer.create(text: "an answer of some kind...", question_id: @question.id)

    @question = Question.create(body: "something more", room_id: @room.id)
    Answer.create(text: "one", question_id: @question.id)
    Answer.create(text: "three", question_id: @question.id)
    Answer.create(text: "four", question_id: @question.id)

    expect {
      join_with_name("ABCD", "username2");

      visit '/rooms/quiz/' + @room.id.to_s + '/question/1'
      choose "option0"

      click_button "Submit"

      # We're back on the response page / main quiz page
      expect(page).to have_content("Asdf")

      expect(page).to have_content("username2")

      # It shows what they answered somewhere
      expect(page).to have_content("an answer of some kind")
    }.to change {Response.all.count}.by(1)

    expect {
      visit '/rooms/quiz/' + @room.id.to_s + '/question/2'
      choose "option1"
      click_button "Submit"

      expect(page).to have_content("Asdf")
      expect(page).to have_content("username2")
      expect(page).to have_content("three")
    }.to change {Response.all.count}.by(1)
  end
end
