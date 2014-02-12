"use strict";

var lifeControllers = angular.module("lifeControllers", []);

lifeApp.controller("BoardCtrl", ["$scope", "$http",
  function($scope, $http){
    $http.get("http://localhost:9393/random_board").success(function(data){
      $scope.boards = data;
    });
  }]);