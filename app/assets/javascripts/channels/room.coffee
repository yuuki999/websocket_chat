App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    result = $('.webchat-form__messages')
    result.append(data['message'])

  speak: (message, name)->
    @perform 'speak', message: message, name: name

  $(document).on 'click', '.webchat-form__button', (event) ->
    App.room.speak $('.webchat-form__input-text').val(),$('.webchat-form__input-name').val()
    $('.webchat-form__input-text').val('')
    $('.webchat-form__input-name').val('')
    event.preventDefault()
