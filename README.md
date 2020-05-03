# README

A webapp that will tell you what can and can't track you in your current session.

## Try it out
Spin up using `rails s` (make sure to `bundle install`). Look through the code for some `byebug`s and re-enable them. You can look through the commits for what I have added. Currently, I have only connected Google's [gtag](https://developers.google.com/analytics/devguides/collection/gtagjs).

The js file will print out all of your cookies to console. In rails, you can use `byebug` and `users_controller#google_tags` to see the gtag cookies.

## Notes
For the browser fingerprinting, I tried to follow EFF's panopticlick method. There are a few differences, though, for the sake of simplicity:
- I did not use PluginDetect, and did not bother doing anything special for IE
- I have not (yet) implemented supercookie tracking

## Goals
For each tracker, show if it is running in user browser session

#### Easy
* Add gtag variable to rails `secrets`

#### Medium

* Add bootstrap to site
* Add google `analytics.js` (only have gtag currently)
* Create our own session tracker
* Try to identify independent users (by a browser fingerprint?)

#### Medium-hard
* Mine bitcoin in user's browser (3rd-party)
* Tell a user how many times they have visited the site
* Make sure we wait for tracker scripts to load up before displaying results

#### Hard
* Mine bitcoin in user's browser (create our own)


## Analytics sources to try
* [Matomo](matomo.org) - google analytics OSS competitor 

## Resources
- [3rd-party guide to google cookies](https://www.optimizesmart.com/google-analytics-cookies-ultimate-guide/#a4)
- [Browser Uniqueness EFF](https://panopticlick.eff.org/static/browser-uniqueness.pdf)
- [fingerprintjs2](https://github.com/Valve/fingerprintjs2)
- [Discussion on fingerprinting browsers with JS, StackOverflow](https://stackoverflow.com/questions/44030666)