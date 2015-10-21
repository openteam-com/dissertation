$ ->
  if $('.js-submenu-toggler').length
    $(".js-submenu-toggler").click ->
      $(this).find(".glyphicon").toggleClass("glyphicon-plus glyphicon-minus")
      $(this).next(".js-submenu").toggleClass("hidden")
      return
    return
  return
