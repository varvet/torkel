$ ->
  $("#push-it").submit ->
    form = $(this)
    message = form.find("input").val()
    Client.send("/bridge/foo", {}, message)
    false

  Client.subscribe "/bridge/foo", (m) ->
    $("<li></li>").text(m.body).appendTo("#messages")
