Roots Netlify
=============================

[![npm](https://badge.fury.io/js/roots-netlify.png)](http://badge.fury.io/js/roots-netlify) [![tests](https://travis-ci.org/carrot/roots-netlify.png?branch=master)](https://travis-ci.org/carrot/roots-netlify) [![dependencies](https://david-dm.org/carrot/roots-netlify.png?theme=shields.io)](https://david-dm.org/carrot/roots-netlify)

A roots extension for creating Netlify configuration files.

> **Note:** This project is in early development, and versioning is a little different. [Read this](http://markup.im/#q4_cRZ1Q) for more details.

### Why Should You Care?

[Netlify](https://www.netlify.com/) is a great static hosting platform that allows developers to add powerful features to their static sites, like [redirects & rewrites](https://docs.netlify.com/) and [headers & basic auth](https://docs.netlify.com/headers_and_basic_auth/).

This abstracts Netlify's config files into your `app.coffee` with the rest of your configs so they can be one big happy family. This also allows you to create different Netlify configs based on your [roots environment](http://roots.readthedocs.org/en/latest/environments.html).

It's also common roots convention to start files with an `_` to ignore files when compiling. Since Netlify is configured with a `_headers` and `_redirects` file, using this extension allows you keep that nice clean convention throughout the whole project.

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
          'ecommerce'
      rewrites:
        '/*': '/index.html'
      headers:
        '/protected/path':
          'Cache-Control': 'max-age: 3000'
          'Basic-Auth': 'username:password'
  ]
```

Read the Netlify documentation on [redirects](https://docs.netlify.com/redirects/) and [headers](https://docs.netlify.com/headers_and_basic_auth) to learn more.

Redirects added to the `redirects` object return a status code of `301` while those added to the `rewrites` object will return `200` (a rewrite). Netlify also [supports](https://docs.netlify.com/redirects#http-status-codes) two other status codes: `302` and `404`. In order to configure your redirects for these, add a `302` or `404` key to `redirects` and nest your configuration object there (see example above).

> **Note:** `302` and `404` redirects are currently not supported in this extension. Use the `redirects` (`301`) or `rewrites` (`200`) configuration keys instead.

### License & Contributing

- Details on the license [can be found here](LICENSE.md)
- Details on running tests and contributing [can be found here](contributing.md)
