class TeacherController < ApplicationController
  def join_existing

  end
  def create

  end
  def start_quiz
    ActionCable.server.broadcast 'quizroom_channel', "Quiz is starting"
  end

  def end_quiz
    ActionCAble.server.broadcast 'quizroom_channel', "Quiz is ending"
  end
end
