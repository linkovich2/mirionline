'use strict'

angular.module 'mirionlineApp'
.controller 'MainCtrl', ($scope, socket) ->
  socket.socket.connect()
