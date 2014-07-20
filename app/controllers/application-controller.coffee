Controller = require '../../lib/controller'

class ApplicationController extends Controller
  urlRoot: '/'
  
  index: (req, res) ->
    res.render('index', title: "Express with CoffeeScript")

module.exports = ApplicationController