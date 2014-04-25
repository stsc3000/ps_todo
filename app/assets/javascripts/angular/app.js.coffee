app = angular.module("app", [])

app.service("TodoService", ($http) ->
  {
    todos: []

    fetch: ->
      $http.get("/todos.json").success (response) =>
        @todos = response

    create: (todo) ->
      $http.post("/todos.json", todo: todo).success (response) =>
        @todos.push(response)

    update: (todo) ->
      $http.put("/todos/#{todo.id}.json", todo: todo).success (response) ->
        angular.copy(response, todo)

    delete: (todo) ->
      $http.delete("/todos/#{todo.id}.json").success (response) =>
        index = @todos.indexOf(todo)
        @todos.splice(index, 1)
  }
)

app.controller("TodosCtrl", ($scope, TodoService) ->
  $scope.title = "My Todos"
  $scope.formData = {}
  $scope.todoService = TodoService
  $scope.todoService.fetch()

  $scope.createTodo = ->
    todo = { title: $scope.formData.title, completed: false }
    $scope.todoService.create(todo)
    $scope.formData = null

  $scope.updateTodo = (todo) ->
    $scope.todoService.update(todo)

  $scope.deleteTodo = (todo) ->
    $scope.todoService.delete(todo)

)
