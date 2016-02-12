RootsUtil = require 'roots-util'
path      = require 'path'
_         = require 'lodash'
W         = require 'when'

module.exports = (opts) ->
  class RootsNetlify
    constructor: (@roots) ->
      @util = new RootsUtil(@roots)

    setup: ->
      W(opts).with(@)
        .then (opts) ->
          @opts = _.defaults(opts, {redirects: {}, headers: {}})
        .then ->
          W.all([write_headers.call(@), write_redirects.call(@)])

    write_headers = ->
      res = _.reduce @opts.headers, (str, conf, path) ->
        str += "#{path}\n"
        str += "  #{k}: #{v}\n" for k, v of conf
        return str
      , ''
      @util.write '_headers', res

    write_redirects = ->
      res = @opts.redirects.join('\n')
      @util.write '_redirects', res
