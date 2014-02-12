"use strict";

var lifeApp = angular.module("lifeApp", [
  "ngRoute",
  "lifeControllers"
  ]);

lifeApp.config(["$routeProvider",
  function($routeProvider){
    when("/random", {
      templateUrl: "partials/randomBoard.html",
      controller: "RandBoardCtrl"
    }).
    otherwise({
      redirectTo: "/random"
    });
  }
  ]);