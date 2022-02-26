var app = angular.module('Login',[]); // same to the above define appName
var app = angular.module('Login',["xeditable"]);

app.run(function(editableOptions) {
  editableOptions.theme = 'bs4';
});

app.factory("svUsers", ["$http", function ($http) {
  return{
    login: function (user) {
      return $http.post("/login", user)
    },
    home: function () {
        window.location.href("/")
      }
  }
}]);

app.controller('LoginCtrl', ['$scope', "svUsers", function($scope, svUsers){
  $scope.appName = "Login!!!";
  $scope.formData = {};
  $scope.datas = [];

  $scope.dataLoading = true;
  //load data from api
  svUsers.get().then(function (datas) {
    $scope.dataLoading = false;
    $scope.datas = datas.data;
  });

  $scope.login = function () {
    $scope.dataLoading = true;
    var user = {
      email: $scope.formData.email,
      password: $scope.formData.password
    };

    svUsers.login(user).then(function (datas) {
      $scope.dataLoading = false;
      svUsers.home();
      $scope.formData.email = "";
      $scope.formData.password = "";
    });
}
}]);