#!/usr/bin/env node
app        = require '../config/app'
startDB    = require '../config/db'
useRoutes  = require '../config/routes'

startDB()
useRoutes(app)

port = process.env.PORT or 3000
app.set('port', port)

app.listen(port)
console.log "Listening on port %d", port
