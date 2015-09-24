$ ->
  if $('.js-progressbar').length
    $(".js-csv-wrapper").hide()
    queryForPercentage()
  return

queryForPercentage = () ->
  job_id = $('.js-progressbar').data('jobid')
  $.ajax
    url: "/job_status"
    data:
      job_id: job_id
    success: (data) ->
      percentage = 'width: ' + data['percent'] + '%;'
      $('.js-progressbar').attr('style', percentage)
      if data['percent'] != 100
        setTimeout(queryForPercentage, 500)
      else
        window.location = window.location.pathname
      return

  return
