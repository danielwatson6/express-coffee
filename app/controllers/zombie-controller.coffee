Controller = require '../../lib/controller'
Zombie     = require '../models/zombie'

class ZombieController extends Controller
  urlRoot: '/zombies'
  model: Zombie

module.exports = ZombieController
