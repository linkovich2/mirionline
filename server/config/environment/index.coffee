'use strict'

path = require "path"
_ = require "lodash"

requiredProcessEnv = (name) ->
  throw new Error "You must set the " + name + " environment variable" unless process.env[name]
  process.env[name];

# All configurations will extend these options
all =
  env: process.env.NODE_ENV

  # Root path of server
  root: path.normalize __dirname + "/../../.."

  # Server port
  port: process.env.PORT or 9000

  # Base URL (passed as global to email templates)
  baseUrl: 'http://localhost:9000'

  # Should we populate the DB with sample data?
  seedDB: false

  # Secret for session, you will want to change this and make it an environment variable
  secrets:
    session: 'BZNMj4yMaMMChJDzXaSmZKfb'

  # List of user roles
  userRoles: ['guest', 'user', 'admin']

  # MongoDB connection options
  mongo:
    options:
      db:
        safe: true

  jwt_options:
    expiresInMinutes: 60 * 5

  sendgrid:
    user: ''
    key: ''

  email:
    from: 'no-reply@minimiri.com'

# Export the config object based on the NODE_ENV
module.exports = _.merge(all, require("./" + process.env.NODE_ENV + ".coffee") or {})
