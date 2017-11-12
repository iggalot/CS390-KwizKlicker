require 'rails_helper'
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

def in_browser(name)
  old_session = Capybara.session_name

  Capybara.session_name = name
  yield

  Capybara.session_name = old_session
end

feature "Create room", :order => :defined do
  scenario "Teacher creates a room and adds a question, then adds some answers to it" do
    visit '/'
    click_on "create_room"
    fill_in "room[name]", :with => "Complex Variables Quiz 1"
    fill_in "room[description]", :with => "Difficult questions about complex variables"
    find('input[name="commit"]').click

    def room_correct
      expect(page).to have_content("Complex Variables Quiz 1")

      expect(page).to have_field("question[body]")
      expect(page).to have_selector("input[type=submit]")
    end

    room_correct

    # Teacher goes back to main page and can select this quiz from their list of quizzes
    visit '/'
    click_on "Complex Variables Quiz 1"

    # Now the teacher adds questions
    fill_in "question[body]", :with => "What's (1/2)!?"
    find('input[name="commit"]').click

    expect(page).to have_content("What's (1/2)!?")


    fill_in "question[body]", :with => "What's (-1/2)!?"
    find('input[name="commit"]').click

    expect(page).to have_content("What's (-1/2)!?")
  end

  scenario "Teacher adds answers to a question after authenticating" do
    @room = Room.create(name: "Asdf", password: "passw", roomcode: "ABCD")
    @question = Question.create(body: "something", room_id: @room.id)

    visit '/rooms/' + @room.id.to_s

    expect(page).to have_content("Needs Authentication")
    fill_in "password", :with => "passw"
    find('input[type=submit]').click

    page.find('a.question').click

    expect(page.current_path).to eql("/rooms/" + @room.id.to_s + "/questions/" + @question.id.to_s)

    # actually add some answers

    expect(page).to have_content("something") # name of the question at hand
    expect(page).to have_selector('li.answer', count: 0)


    fill_in "answer[text]", :with => "sqrt(pi)/2"
    find('input[name="commit"]').click

    fill_in "answer[text]", :with => "sqrt(pi)"
    find('input[name="commit"]').click

    fill_in "answer[text]", :with => "-sqrt(pi)/2"
    find('input[name="commit"]').click


    fill_in "answer[text]", :with => "-sqrt(pi)"
    find('input[name="commit"]').click


    expect(page).to have_selector('li.answer', count: 4)
  end

  scenario "Teacher activates the room / presents it to the class" do
    @room = Room.create(name: "Asdf", password: "passw", roomcode: "ABCD")

    in_browser(:teacher) do
      visit '/rooms/' + @room.id.to_s
      fill_in "password", :with => "passw"
      find('input[type=submit]').click

      page.find('#start_quiz').click

      # They are presented with the remote
      expect(page.current_path).to eql('/rooms/remote/' + @room.id.to_s)

      @room = Room.find(@room.id)
      expect(@room.state).to eql("active")

      expect(page).to have_selector('#next_question')
    end

    in_browser(:student) do
      visit '/'
      click_on 'Join Room'
    end

  end
end