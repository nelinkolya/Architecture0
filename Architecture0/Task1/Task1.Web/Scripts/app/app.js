angular
    .module("task1", ["ui.router", "ngLodash", "timer", "angular-momentjs"]);

angular.module("task1").config(config);

config.$inject = ["$stateProvider", "$urlRouterProvider", "$locationProvider"];

function config($stateProvider, $urlRouterProvider, $locationProvider) {
    $urlRouterProvider.otherwise("/home");
    $locationProvider.html5Mode(true); //todo:n

    $stateProvider
        .state("home", {
            url: "/home",
            templateUrl: "/Scripts/app/home.html",
            controller: "homeCtrl",
            controllerAs: "vm"
        });
}