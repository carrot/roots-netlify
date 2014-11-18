path      = require 'path'
fs        = require 'fs'
should    = require 'should'
Roots     = require 'roots'
_path     = path.join(__dirname, 'fixtures')
RootsUtil = require 'roots-util'
h = new RootsUtil.Helpers(base: _path)

# setup, teardown, and utils

compile_fixture = (fixture_name, done) ->
  @public = path.join(fixture_name, 'public')
  h.project.compile(Roots, fixture_name, done)

before (done) ->
  h.project.install_dependencies('*', done)

after ->
  h.project.remove_folders('**/public')

# tests

describe 'basic setup', ->

  before (done) -> compile_fixture.call(@, 'basic', -> done())

  it 'compiles basic project', ->
    p = path.join(@public, 'index.html')
    h.file.exists(p).should.be.ok

  it 'compiles the headers config file correctly', ->
    compiled = path.join(@public, '_headers')
    expected = path.join(@public, 'expected', '_headers')
    h.file.matches_file(compiled, expected).should.be.true

  it 'compiles the redirects config file correctly', ->
    compiled = path.join(@public, '_redirects')
    expected = path.join(@public, 'expected', '_redirects')
    h.file.matches_file(compiled, expected).should.be.true
