# README

A webapp that will tell you what can and can't track you in your current session.

As of 5/18/20, it uses two seperate methods to uniquely identify the user. For each, it will keep track of how many times the user has visited, and when the last visit was.
  1. Google's gtag.js
  2. Fingerprinting the user's browser using various methods

## Try it out
Spin up using `rails s` (make sure to `bundle install` and `rails db:create && rails db:migrate`). Take a look at `users_controller.rb` and put some byebugs in different places. You can look through the commits for what I have added. Currently, I have only connected Google's [gtag](https://developers.google.com/analytics/devguides/collection/gtagjs).

The js file will print out all of your cookies to console. In rails, you can use `byebug` and `users_controller#google_tags` to see the gtag cookies.

## Notes
For the browser fingerprinting, I tried to follow EFF's [panopticlick method](https://panopticlick.eff.org/static/browser-uniqueness.pdf). There are a few differences, though, for the sake of simplicity:
- I did not use PluginDetect, and did not bother doing anything special for IE
- I have not (yet) implemented supercookie tracking

## Goals
For each tracker, show if it is running in user browser session

#### Easy
* Add gtag variable to rails `secrets`

#### Medium

* Add google `analytics.js` (only have gtag currently)

#### Medium-hard
* Mine bitcoin in user's browser (3rd-party)
* Supercookie tracking
* Link gtag with fingerprint in an effort to identify when there are fingerprint collisions
  * (multiple users with the same fingerprints)

#### Hard
* Mine bitcoin in user's browser (create our own)

## Analytics sources to try
* [Matomo](matomo.org) - google analytics OSS competitor 

## Resources
- [3rd-party guide to google cookies](https://www.optimizesmart.com/google-analytics-cookies-ultimate-guide/#a4)
- [Browser Uniqueness EFF](https://panopticlick.eff.org/static/browser-uniqueness.pdf)
- [fingerprintjs2](https://github.com/Valve/fingerprintjs2)
- [Discussion on fingerprinting browsers with JS, StackOverflow](https://stackoverflow.com/questions/44030666)