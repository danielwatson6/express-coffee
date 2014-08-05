Controller = require '../../lib/controller'
Zombie     = require '../models/zombie'

class ApplicationController extends Controller
  urlRoot: '/'
  
  index: (req, res) ->
    Zombie.find (err, zombies) ->
      if err then res.send(err)
      res.render('index', zombies: JSON.stringify(zombies))

module.exports = ApplicationController
