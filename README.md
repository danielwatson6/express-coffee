Express with CoffeeScript
=========================

This example project includes a setup for using coffeescript in express.js in the backend

## Features

### MVC

In the `app` directory, you can find subfolders for models, views, and controllers

Models use mongoose. Example model:
    
    # app/models/zombie.coffee
    
    mongoose = require 'mongoose'

    ZombieSchema = new mongoose.Schema
      name: String
      graveyard: String

    module.exports = mongoose.model('Zombie', ZombieSchema)

### Built-in REST API

The `Controller` class in the `lib` folder includes CRUD operations and a `router` method. Example controller:
    
    # app/controllers/zombie-controller.coffee
    
    Controller = require '../../lib/controller'
    Zombie     = require '../models/zombie'

    class ZombieController extends Controller
      urlRoot: '/zombies'
      
      index: (req, res) ->
        Zombie.find( (err, zombies) ->
          if err then res.send(err)
          res.json(zombies)
        )
      
      show: (req, res) ->
        Zombie.findById( req.params.id, (err, zombie) ->
          if err then res.send(err)
          res.json(zombie)
        )
      
      create: (req, res) ->
        zombie = new Zombie
        zombie.name = req.body.name
        zombie.graveyard = req.body.graveyard
        zombie.save (err) ->
          if err then res.send(err)
          res.json(message: "Zombie created!")
      
      update: (req, res) ->
        Zombie.findById(req.params.id, (err, zombie) ->
          if err then res.send(err)
          zombie.name = req.body.name
          zombie.graveyard = req.body.graveyard
          zombie.save (err) ->
            if err then res.send(err)
            res.json(message: "Zombie updated!")
        )
      
      destroy: (req, res) ->
        Zombie.remove(_id: req.params.id, (err, zombie) ->
          if err then res.send(err)
          res.json(message: "Zombie destroyed!")
        )
    
    module.exports = ZombieController

To use a controller in the app and route accordingly, set `urlRoot` property in controller and add the controller to the app file:
    
    zombieController = new ZombieController
    app.use zombieController.router(rest: true)

## Dependencies

This project requires CoffeeScript and MongoDB installed locally
By default, templates are using jade, and stylesheets are using stylus

## Using

To use this setup, run `git clone git://github.com/djwatt5/express-coffee.git`
