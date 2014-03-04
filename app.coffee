'use strict'

$ ->
  $('form').on "submit", (event) ->
    event.preventDefault()
    $("#poster").html('')
    $('h1').text('Results')
    searchTerm = $('#name').val()
    year = parseInt $('#year').val()
    movieData = $.ajax
      url: "http://www.omdbapi.com/"
      method: "get"
      data: { 
        s: searchTerm
        y: year if year 
      }
      dataType: "json"
    
    movieData.done (data) ->
      $('#name').val('')
      $('#year').val('')
      $(".result").html('')
      movies = data['Search']
      if movies.length > 0
        for movie in movies
          li = $('<li data-imdbid="' + movie.imdbID + '">' + movie.Title + ' (' + movie.Year + ')</li>')
          $('.result').append li


  $('section').delegate('li', 'click', ->
    $("#poster").html('')
    imdbId = $(@).attr("data-imdbid")

    movie = $.ajax
      url: "http://www.omdbapi.com/"
      method: "get"
      data: { i: imdbId }
      dataType: "json"

    movie.done (data) ->
      poster = data['Poster']
      unless poster == 'N/A'
        img = $('<img src="' + poster + '" alt="poster" />')
        $('#poster').append img
    )