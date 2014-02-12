"use strict";

var lifeControllers = angular.module("lifeControllers", []);

lifeApp.controller("BoardCtrl", ["$scope", "$http", "$timeout",
  function($scope, $http, $timeout){
    $http.get("http://localhost:4000/random_board").success(function(data){
      $scope.boards = data;
    
      var nextMove = function(){
        $scope.boards.shift();
        $timeout(nextMove, 1000);
      }

      nextMove();
    });
  }]);