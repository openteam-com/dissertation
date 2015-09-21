$ ->
  if $('.js-progressbar').length
    queryForPercentage()
    $(".js-csv-wrapper").hide()

queryForPercentage = () ->
  job_id = $('.js-progressbar').data('jobid')
  $.ajax
    url: "/job_status"
    data:
      job_id: job_id
    success: (data) ->
      percentage = 'width: ' + data['percent'] + '%;'
      $('.js-progressbar').attr('style', percentage)
      if  data['percent'] != 100
        setTimeout(queryForPercentage, 500)
      else
        $(".js-progress").hide()
        getCSVInfo()

getCSVInfo = () ->
  $.ajax
    success: (data) ->
      $(".js-panel-body").append(data)
