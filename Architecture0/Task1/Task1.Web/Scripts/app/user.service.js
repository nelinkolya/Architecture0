angular
    .module("task1")
    .service("userService", userService);

userService.$inject = ["$http", "$q"];

function userService($http, $q) {
    var user = null;
    var service = {
        getCurrentUser: getCurrentUser
    }

    function getCurrentUser() {
        var deferred = $q.defer();

        if (user == null) {
            $http.get("/home/getCurrentUser").then(function (r) {
                user = r.data;
                deferred.resolve(user);
            });
        } else {
            deferred.resolve(user);
        }
        return deferred.promise;
    }

    return service;
}