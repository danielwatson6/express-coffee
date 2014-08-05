Controller = require '../../lib/controller'
Post       = require '../models/zombie'

class PostController extends Controller
  urlRoot: '/posts'
  model: Post

module.exports = PostController
