netlify = require '../../..'
W       = require 'when'

config =
  redirects: [
    '/* /index.html 200'
    '/news /blog 301'
    '/news/:year/:month:/:date/:slug /blog/:year/:month/:date/:story_id 301'
    '/news/* /blog/:splat 301'
    '/temp_redirect / 302'
    '/ecommerce /closed 404'
  ]
  headers:
    '/protected/path':
      'Cache-Control': 'max-age: 3000'
      'Basic-Auth': 'username:password'
    '/*':
      'X-Frame-Options': 'DENY'
      'X-XSS-Protection': '1; mode=block'

module.exports =
  ignores: ["**/.DS_Store"]
  extensions: [
    netlify(W.resolve(config))
  ]
