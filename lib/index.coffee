RootsUtil = require 'roots-util'
path      = require 'path'
_         = require 'lodash'

module.exports = (opts) ->
  class RootsNetlify
    constructor: (@roots) ->
      @util = new RootsUtil(@roots)

    setup: ->
      write_headers.call(@, opts.headers)

    write_headers = (headers) ->
      res = _.reduce headers, (res, conf, path) ->
        res += "#{path}\n"
        res += "  #{k}: #{v}\n" for k, v of conf
        return res
      , ''
      @util.write '_headers', res
