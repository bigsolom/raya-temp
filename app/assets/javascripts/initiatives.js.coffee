# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $("#form").hide()
  $(".btn.btn-link").click ->
    $("#sectors").hide()
    $("#form").show()
    $("#initiative_sector_id").val $(this).val()
    return

  return