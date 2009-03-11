# TweetScope #

TweetScope makes it easy to create themed single-page displays of twitter search results. (See these sites tracking [#afterhours](http://afterhours.reidab.com/), [#getoffmylawn](http://getoffmylawn.reidab.com/), and [CyborgCamp](http://cyborgcamp.reidab.com/) for example.)

## Quick Setup ##

1. Create a new site with rake site:create
2. Edit your site's config.yml file (sites/sitename/config.yml) to set your site's title, tagline, query, and the number of results to display.
4. Customize the appearance of your site by editing the css file (public/sitename/style.css) and the view template (sites/sitename/index.haml). The view template is written using [haml](http://haml.hamptoncatlin.com/).
5. Test things out by running `ruby tweetscope.rb` and visiting [http://localhost:4567](http://localhost:4567) in your browser.

## Configuration ##

### Global Configuration ###
The global\_config.yml file holds application-level settings.

* __default_site__: directory name of the default site to be served in a multi-site installation if no domain match is found. If this option is not set, TweetScope will display the first site alphabetically.
* __cache\_max\_age__: cache expiry time, in seconds. No caching is performed by TweetScope itself, this simply sets the value of the Cache-Control header for use with an external caching system.

### Site Configuration ###
Each site's config.yml file holds site-specific settings. 

#### Query Settings ####

* __query__: the query string passed to [twitter search](http://search.twitter.com/)
* __language__: restricts tweets to the given language, given by an [ISO 639-1 code](http://en.wikipedia.org/wiki/ISO_639-1).
* __count__: the number of tweets to return per page, up to a maximum of 100.
* __geocode__: returns tweets by users located within a given radius of the given latitude/longitude, where the user's location is taken from their Twitter profile. The parameter value is specified by "latitide,longitude,radius", where radius units must be specified as either "mi" (miles) or "km" (kilometers). Note that you cannot use the near operator via the API to geocode arbitrary locations; however you can use this geocode parameter to search near geocodes directly.

#### Text Snippets ####
The default theme uses the config file to set the site title and tagline. Additional snippets of text can be added following the same key/value convention and accessed in the view template with `@site['keyname']`.

#### Site Settings ####

* __cache\_max\_age__: the global cache expiration can be overridden on a site-by-site basis.
* __domain__: a domain where this site is accessible (see _Multiple Sites_ below).
* __domains__: a collection of domains where this site is accessible (see _Multiple Sites_ below).

## Multiple Sites ##

A single instance of TweetScope can run many different sites. The domain (or subdomain) being requested is checked against all sites that have the _domain_ or _domains_ option set. If a match is found, that site is served.

When testing locally, sites can be accessed at http://localhost:4567/_sitename_

## Deployment ##

The current version of TweetScope is targeted for deployment on Heroku (it includes unpacked gems necessary for running there), but will play nicely with any [Rack](http://rack.rubyforge.org/)-compatible webserver. A guide to Heroku deployment can be found at [http://wiki.github.com/reidab/tweetscope/easy-deployment-to-heroku](http://wiki.github.com/reidab/tweetscope/easy-deployment-to-heroku).