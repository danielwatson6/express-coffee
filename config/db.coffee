mongoose = require 'mongoose'

module.exports = ->
  
  # Mongoose setup
  mongoose.connect('mongodb://localhost/foo')
  db = mongoose.connection
  db.on('error', console.error.bind(console, 'connection error:'))
  
  return
