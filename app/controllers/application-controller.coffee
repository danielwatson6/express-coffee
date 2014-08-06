Controller = require '../../lib/controller'

class ApplicationController extends Controller
  hi: (req, res) ->
    res.render('index')

module.exports = ApplicationController
