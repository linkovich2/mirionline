'use strict'

angular.module 'mirionlineApp'
.controller 'CharacterCreateCtrl', ($scope, socketProvider, Auth) ->
  socketProvider.socket.connect()
  $scope.character = {}

  $scope.createCharacter = ->
    # do something!
    return
