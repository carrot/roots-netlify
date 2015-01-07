RootsUtil = require 'roots-util'
path      = require 'path'
_         = require 'lodash'
W         = require 'when'

module.exports = (opts) ->
  codes = ['200', '301', '302', '404']

  class RootsNetlify
    constructor: (@roots) ->
      @util = new RootsUtil(@roots)

    setup: ->
      W(opts).with(@)
        .then (opts) ->
          @opts = _.defaults(opts, {redirects: {}, rewrites: {}, headers: {}})
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
      redirects = _.pick(@opts.redirects, codes)
      redirects['200'] ?= {}
      redirects['301'] ?= {}
      _.merge(redirects['200'], @opts.rewrites)
      _.merge(redirects['301'], _.omit(@opts.redirects, codes))

      res = _.reduce redirects, (str, conf, code) ->
        for k, v of conf
          str += "#{k} #{v} #{code}\n"
        return str
      , ''
      @util.write '_redirects', res
