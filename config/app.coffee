express       = require 'express'
fs            = require 'fs'
favicon       = require 'static-favicon'
morgan        = require 'morgan'
cookieParser  = require 'cookie-parser'
bodyParser    = require 'body-parser'
stylus        = require 'stylus'
connectAssets = require 'connect-assets'
paths         = require './paths'
expressCoffee = require '../lib/express-coffee'

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


module.exports = app
