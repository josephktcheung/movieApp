"use strict"

@movieApp = angular.module 'movieApp', []

class MoviePanel
  constructor: (@$scope, @$http) ->
    @$scope.search = @search

  search: =>
    @searchTerm = @$scope.searchInput
    console.log @searchTerm
    if @searchTerm
      @$http(
        url: "http://www.omdbapi.com/"
        method: "get"
        params: { s: @searchTerm }
      ).success( (data, status, headers, config) =>
        @$scope.results = data['Search']
      )

MoviePanel.$inject = ["$scope", '$http']
movieApp.controller "MoviePanel", MoviePanel