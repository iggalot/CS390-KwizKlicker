App.quizroom = App.cable.subscriptions.create "QuizroomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    switch(data.action)
      when 'join_room'
        alert(data.content)
      when 'quiz_start'
        alert("Quiz is now starting")

