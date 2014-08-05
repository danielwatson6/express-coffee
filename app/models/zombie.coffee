mongoose = require 'mongoose'

ZombieSchema = new mongoose.Schema
  name: String
  age: Number
  graveyard: String

module.exports = mongoose.model('Zombie', ZombieSchema)
