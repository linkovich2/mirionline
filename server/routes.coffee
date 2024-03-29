###
Main application routes
###

"use strict"

path = require "path"

module.exports = (app) ->
  # Insert routes below
  app.use "/api/users", require("./api/user")

  app.use "/auth", require("./auth")

  # All undefined asset or api routes should return a 404
  app.route("/:url(api|auth|components|app|bower_components|assets)/*").get (req, res) ->
    res.status(404).end()

  # All other routes should redirect to the index.html
  app.route("/*").get (req, res) ->
    res.sendFile path.resolve(app.get("appPath") + "/index.html")
