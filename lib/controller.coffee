express = require 'express'

properties = (model) ->
  result = []
  keylist = Object.keys(model.schema.paths)
  for k in keylist
    if k.indexOf('_') isnt 0 then result.push(k)
  result

class Controller
  
  urlRoot: ''
  model: null
  
  # Create a router object and return it
  router: (options) ->
    router = express.Router()
    # Use Rest API if specified
    if options and options.rest
      router.route(@urlRoot)
        .get( (req, res) =>
          @model.find (err, models) ->
            if err then res.send(err)
            res.json(models)
        )
        .post( (req, res) =>
          props = properties(@model)
          e = new @model
          for p in props
            e[p] = req.body[p]
          e.save (err, model) ->
            if err then res.send(err)
            res.json(_id: model.id)
        )
      router.route(@urlRoot + '/:id')
        .get( (req, res) =>
          @model.findById (err, model) ->
            if err then res.send(err)
            res.json(model)
        )
        .put( (req, res) =>
          @model.findById req.params.id, (err, e) =>
            if err then res.send(err)
            props = properties(@model)
            for p in props
              e[p] = req.body[p]
            e.save (err, model) ->
              if err then res.send(err)
              res.json(model)
        )
        .delete( (req, res) =>
          @model.remove _id: req.params.id, (err) ->
            if err then res.send(err)
        )
    else
      router.get(@urlRoot, @index)
    router

module.exports = Controller
