express      = require 'express'
path         = require 'path'
fs           = require 'fs'
favicon      = require 'static-favicon'
morgan       = require 'morgan'
cookieParser = require 'cookie-parser'
bodyParser   = require 'body-parser'
stylus       = require 'stylus'

# App setup
app = express()
app.use favicon()
app.use morgan('dev')
app.use bodyParser()
app.use cookieParser()
app.use express.static(path.join(__dirname, 'public'))
app.set('views', path.join(__dirname, 'app', 'views'))

# Engines for views and stylesheets
app.set('view engine', 'jade')
app.use stylus.middleware(path.join(__dirname, 'public'))

# Coffeescript setup
env = app.get('env')
app.use require('express-coffee')(
  path: path.join(__dirname, 'public')
  live:   env isnt 'production'
  uglify: env is 'production'
  debug:  env isnt 'production'
)

# MongoDB setup
mongoose = require 'mongoose'
mongoose.connect('mongodb://localhost/foo')
db = mongoose.connection
db.on('error', console.error.bind(console, 'connection error:'))

# Initialize controllers
ApplicationController = require './app/controllers/application-controller'

# Route controllers
app.use (new ApplicationController).router()


module.exports = app
