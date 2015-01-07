Roots Netlify
=============================

[![npm](https://badge.fury.io/js/roots-netlify.png)](http://badge.fury.io/js/roots-netlify) [![tests](https://travis-ci.org/carrot/roots-netlify.png?branch=master)](https://travis-ci.org/carrot/roots-netlify) [![dependencies](https://david-dm.org/carrot/roots-netlify.png?theme=shields.io)](https://david-dm.org/carrot/roots-netlify) [![Coverage Status](https://img.shields.io/coveralls/carrot/roots-netlify.svg)](https://coveralls.io/r/carrot/roots-netlify?branch=master)

A roots extension for creating Netlify configuration files.

> **Note:** This project is in early development, and versioning is a little different. [Read this](http://markup.im/#q4_cRZ1Q) for more details.

### Why Should You Care?

[Netlify](https://www.netlify.com/) is a great static hosting platform that allows developers to add powerful features to their static sites, like [redirects & rewrites](https://docs.netlify.com/) and [headers & basic auth](https://docs.netlify.com/headers_and_basic_auth/).

This abstracts Netlify's config files into your `app.coffee` with the rest of your configs so they can be one big happy family. This also allows you to create different Netlify configs based on your [roots environment](http://roots.readthedocs.org/en/latest/environments.html).

It's also a common roots convention to start files with an `_` to ignore them during compilation. Since Netlify would normally be configured with a `_headers` and `_redirects` file, using this extension allows you keep that nice clean convention throughout the whole project.

### Installation & Usage

- make sure you are in your roots project directory
- `npm install roots-netlify --save`
- modify your `app.coffee` file to include the extension, as such

```coffee
netlify = require 'roots-netlify'

module.exports =
  extensions: [
    netlify
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
  ]
```

Read the Netlify documentation on [redirects](https://docs.netlify.com/redirects/) and [headers](https://docs.netlify.com/headers_and_basic_auth) to learn more.

Redirects added to the `redirects` object return a status code of `301` while those added to the `rewrites` object will return `200` (a rewrite). Netlify also [supports](https://docs.netlify.com/redirects#http-status-codes) two other status codes: `302` and `404`. In order to configure your redirects for these, add a `302` or `404` key to `redirects` and nest your configuration object there (see example above).

### Promises

Instead of passing the regular options object into the extension, you can also pass a promise for an options object in case you need to perform any asynchronous work (such as loading a file or making an http request) before configuring roots-netlify.


```coffee
fs     = require 'fs'
nodefn = require 'when/node'
yaml   = require 'js-yaml'

config = nodefn.call(fs.readFile, 'config.yaml')
  .then (contents) -> yaml.safeLoad(contents)

module.exports =
  extensions: [
    netlify(config)
  ]
```

### License & Contributing

- Details on the license [can be found here](LICENSE.md)
- Details on running tests and contributing [can be found here](contributing.md)
