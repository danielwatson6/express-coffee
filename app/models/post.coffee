mongoose = require 'mongoose'

PostSchema = new mongoose.Schema
  title: String
  content: String
  createdAt: Date
  zombieId: String

module.exports = mongoose.model('Post', PostSchema)
