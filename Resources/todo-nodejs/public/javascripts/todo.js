var app = angular.module('myApp',[]); // same to the above define appName
var app = angular.module('myApp',["xeditable"]);

app.run(function(editableOptions) {
  editableOptions.theme = 'bs4';
});

app.factory("svTodos", ["$http", function ($http) {
  return{
    get: function () {
      return $http.get("/todo/alls");
    },
    create: function (todoData) {
      return $http.post("/todo", todoData)
    },
    update: function (todoData) {
      return $http.put("/todo/" + todoData._id, todoData)
    },
    delete: function (id) {
      return $http.delete("/todo/" + id)
    }
  }
}]);

app.controller('Ctrl', ['$scope', "svTodos", function($scope, svTodos){
  $scope.appName = "Checklist Todo!!!";
  $scope.formData = {};
  $scope.todos = [];

  $scope.dataLoading = true;
  //load data from api
  svTodos.get().then(function (datas) {
    $scope.dataLoading = false;
    $scope.todos = datas.data;
  });

  $scope.createTodo = function () {
    $scope.dataLoading = true;
    var todo = {
      text: $scope.formData.text,
      isDone: false
    };

    svTodos.create(todo).then(function (datas) {
      $scope.dataLoading = false;
      $scope.todos = datas.data;
      $scope.formData.text = "";
    });
    
  }

  $scope.updateTodo = function (todo) {
    $scope.dataLoading = true;
    svTodos.update(todo).then(function (datas) {
      $scope.dataLoading = false;
      $scope.todos = datas.data;
    });

  }
  
    $scope.deleteTodo = function (todo) {
      $scope.dataLoading = true;
      svTodos.delete(todo._id).then(function (datas) {
        $scope.dataLoading = false;
      $scope.todos = datas.data;
    });
    }
}]);