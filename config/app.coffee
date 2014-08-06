express       = require 'express'
fs            = require 'fs'
favicon       = require 'static-favicon'
morgan        = require 'morgan'
cookieParser  = require 'cookie-parser'
bodyParser    = require 'body-parser'
stylus        = require 'stylus'
connectAssets = require 'connect-assets'
paths         = require './paths'
routes        = require './routes'
expressCoffee = require '../lib/express-coffee'
buildRouter   = require '../lib/build-router'

route = (app, name, options) ->
  controller = require "#{paths.controllers}/#{name}"
  options.action = controller[options.action]
  app.use buildRouter(options)

# App setup
app = express()
app.use favicon()
app.use morgan('dev')
app.use bodyParser()
app.use cookieParser()
app.use express.static(paths.public)
app.set('views', paths.views)

# Jade setup for backend
app.set('view engine', 'jade')

# Coffeescript for backend
env = app.get('env')
app.use expressCoffee
  path:   paths.public
  live:   env isnt 'production'
  uglify: env is 'production'
  debug:  env isnt 'production'

# Front end assets
app.use connectAssets
  paths: [paths.javascripts, paths.stylesheets, paths.templates]

# Routes
for r of routes
  options = {}
  options.method = r.split(' ')[0]
  options.path   = r.split(' ')[1]
  options.action = routes[r].split('#')[1]
  route(app, routes[r].split('#')[0], options)

module.exports = app
