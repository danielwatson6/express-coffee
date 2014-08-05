paths = require './paths'

route = (app, name, options) ->
  Controller = require "#{paths.controllers}/#{name}"
  app.use (new Controller).router(options)


module.exports = (app) ->
  route app, 'application-controller'
  return
