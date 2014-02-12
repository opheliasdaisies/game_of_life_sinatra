"use strict";

var lifeApp = angular.module("lifeApp", [
  "ngRoute",
  "lifeControllers"
  ]);

lifeApp.config(["$routeProvider",
  function($routeProvider){
    $routeProvider.
      when("/random", {
        templateUrl: "partials/randomBoard.html",
        controller: "BoardCtrl"
      }).
      otherwise({
        redirectTo: "/random"
      });
  }]);