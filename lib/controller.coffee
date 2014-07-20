express = require 'express'

class Controller
  
  urlRoot: ''
  
  # Overridable CRUD operations
  index: (req, res) ->
  show: (req, res) ->
  create: (req, res) ->
  update: (req, res) ->
  destroy: (req, res) ->
  
  # Create a router object and return it
  router: (options) ->
    router = express.Router()
    # Add RESTful routes if specified
    if options and options.rest
      router.route(@urlRoot)
        .get( @index )
        .post( @create )
      router.route(@urlRoot + '/:id')
        .get( @show )
        .put( @update )
        .delete( @destroy )
    else
      router.get(@urlRoot, @index)
    router

module.exports = Controller
