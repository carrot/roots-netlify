netlify = require '../../..'
W       = require 'when'

config =
  redirects:
    '/news': '/blog'
    '/news/:year/:month:/:date/:slug': '/blog/:year/:month/:date/:story_id'
    '/news/*': '/blog/:splat'
    '302':
      '/temp_redirect': '/'
    '404':
      '/ecommerce': '/closed'
  rewrites:
    '/*': '/index.html'
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
