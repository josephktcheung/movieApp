"use strict"

@movieApp = angular.module 'movieApp', []

movieApp.controller 'MovieController', ($scope, $http) ->

  $scope.years = [1940..2014]

  getDetails = (data) ->
    movieDetails = $scope.movieDetails = data
    $scope.movieDetails.Poster = '' if $scope.movieDetails.Poster == 'N/A'
    $scope.showDetail = true
    $('#star').raty()
    $('#star').raty('score', (parseInt movieDetails.imdbRating) / 2)
    $('#star').raty('readOnly', true)

  $scope.search = ->
    movieName = $scope.movieName
    year = $scope.movieYear
    if movieName
      $http({
        url: "http://www.omdbapi.com/"
        method: "GET"
        params: {
          s: movieName
          y: year if year
        }
      }).success( (data, status, headers, config) ->
        $scope.movies = data['Search']
      ).error( (data, status, headers, config) ->
        $scope.status = status
      )

  $scope.getDetails = (e) ->
    fullPlot = $scope.fullPlot
    imdbID = e.target.attributes[0].value
    $http({
      url: "http://www.omdbapi.com/"
      method: "GET"
      params: {
        i: imdbID
        tomatoes: true
        plot: 'full' if fullPlot
      }
    }).success( (data, status, headers, config) ->
      getDetails(data)
    ).error( (data, status, headers, config) ->
      $scope.status = status
    )




# class MoviePanel
#   constructor: (@$scope, @$http) ->
#     $scope.movieName = "matrix"

#     $scope.search: =>
#       console.log(@$scope.movieName)
#       if @$scope.movieName
#         movieName = $scope.movieName
#         console.log movieName

#         $http(
#           url: "http://www.omdbapi.com/"
#           method: "get"
#           params: { s: movieName }
#         ).success( (data, status, headers, config) ->
#           console.log("data: " + data + "status: " + status + "headers:" + headers + "config: " + config)
#           results(data)
#         ).error( (data, status, headers, config) ->
#           $scope.status = status
#         )

#         results = (data) ->
#           for movie in data["Search"]
#             console.log data
#             console.log movie.Title
#             $(".result").append("<li>" + movie.Title + "</li>")

# MoviePanel.$inject = ["$scope", "$http"]
# movieApp.controller "MoviePanel", MoviePanel