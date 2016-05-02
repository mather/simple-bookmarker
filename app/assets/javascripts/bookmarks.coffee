# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('#tags').tagit
    availableTags: gon.available_tags

$(document).ready(ready)
$(document).on("page:load", ready)

@fetchTitle = ->
  targetUrl = $("#bookmark_url").val()
  request = $.get '/fetch_title.json?url=' + targetUrl
  request.success (data) ->
    $('#bookmark_title').val(data.title)
