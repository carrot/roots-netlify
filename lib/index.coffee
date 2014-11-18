RootsUtil = require 'roots-util'
path = require 'path'

module.exports = (opts) ->
  class RootsNetlify
    constructor: (@roots) ->
      @util = new RootsUtil(@roots)

    setup: ->
