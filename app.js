// Generated by CoffeeScript 1.6.2
(function() {
  'use strict';  $(function() {
    $('form').on("submit", function(event) {
      var movieData, searchTerm, year;

      event.preventDefault();
      $("#poster").html('');
      $('h1').text('Results');
      searchTerm = $('#name').val();
      year = parseInt($('#year').val());
      movieData = $.ajax({
        url: "http://www.omdbapi.com/",
        method: "get",
        data: {
          s: searchTerm,
          y: year ? year : void 0
        },
        dataType: "json"
      });
      return movieData.done(function(data) {
        var li, movie, movies, _i, _len, _results;

        $('#name').val('');
        $('#year').val('');
        $(".result").html('');
        movies = data['Search'];
        if (movies.length > 0) {
          _results = [];
          for (_i = 0, _len = movies.length; _i < _len; _i++) {
            movie = movies[_i];
            li = $('<li data-imdbid="' + movie.imdbID + '">' + movie.Title + ' (' + movie.Year + ')</li>');
            _results.push($('.result').append(li));
          }
          return _results;
        }
      });
    });
    return $('section').delegate('li', 'click', function() {
      var imdbId, movie;

      $("#poster").html('');
      imdbId = $(this).attr("data-imdbid");
      movie = $.ajax({
        url: "http://www.omdbapi.com/",
        method: "get",
        data: {
          i: imdbId
        },
        dataType: "json"
      });
      return movie.done(function(data) {
        var img, poster;

        poster = data['Poster'];
        if (poster !== 'N/A') {
          img = $('<img src="' + poster + '" alt="poster" />');
          return $('#poster').append(img);
        }
      });
    });
  });

}).call(this);
