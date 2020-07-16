# Creepy Tracker
### A webapp that will tell you what can and can't track you in your current session.
[Webapp](https://creepy-tracker.herokuapp.com/)

![website snapshot](.github/images/Screen%20Shot%202020-07-16%20at%209.29.38%20AM.png "What you might see")

We two seperate methods to uniquely identify the user. For each, it will keep track of how many times the user has visited, and when the last visit was.
  1. Google's gtag.js
  2. Fingerprinting the user's browser using various methods

Additionally, you can see the data points used for your fingerprint.
## Try it out
Spin up using `rails s` (make sure to `bundle install` and `rails db:create && rails db:migrate`). Take a look at `users_controller.rb` and put some byebugs in different places. You can look through the commits for what I have added. Currently, my only 3rd-party tracker is Google's [gtag](https://developers.google.com/analytics/devguides/collection/gtagjs).

The js file (`main.js`) will print out all of your cookies to console. In rails, you can use `byebug` with `users_controller#google_tags` to see the gtag cookies. Note that the page needs to first submit a POST request to `/create` before you will get anything in rails.

## Notes
For the browser fingerprinting, I tried to follow EFF's [panopticlick method](https://panopticlick.eff.org/static/browser-uniqueness.pdf). There are a few differences, though, for the sake of simplicity:
- I did not use PluginDetect, and did not bother doing anything special for IE
- I have not (yet) implemented supercookie tracking

## Further Goals
For each tracker, show if it is running in user browser session

#### Easy
* Add gtag variable to rails `secrets`
* More in-depth explanation of fingerprinting process

#### Medium

* Add google `analytics.js` (only have gtag currently)

#### Medium-hard
* Mine bitcoin in user's browser (3rd-party)
* Supercookie tracking
* Link gtag with fingerprint in an effort to identify when there are fingerprint collisions
  * (multiple users with the same fingerprints)
* Create custom cookie to connect to fingerprint (identify collisions, or a fingerprint change with a given user)

#### Hard
* Mine bitcoin in user's browser (create our own)

## Analytics sources to try
* [Matomo](matomo.org) - google analytics OSS competitor 

## Resources
- [3rd-party guide to google cookies](https://www.optimizesmart.com/google-analytics-cookies-ultimate-guide/#a4)
- [Browser Uniqueness EFF](https://panopticlick.eff.org/static/browser-uniqueness.pdf)
- [fingerprintjs2](https://github.com/Valve/fingerprintjs2)
- [Discussion on fingerprinting browsers with JS, StackOverflow](https://stackoverflow.com/questions/44030666)

## Other content you may be interested in
- [amiunique.org](https://amiunique.org/)
- [http://fp.virpo.sk/](http://fp.virpo.sk/)