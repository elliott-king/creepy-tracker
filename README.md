# README

A webapp that will tell you what can and can't track you in your current session.

## Try it out
Spin up using `rails s` (make sure to `bundle install`). Look through the code for some `byebug`s and re-enable them. You can look through the commits for what I have added. Currently, I have only connected Google's [gtag](https://developers.google.com/analytics/devguides/collection/gtagjs).

The js file will print out all of your cookies to console. In rails, you can use `byebug` and `users_controller#google_tags` to see the gtag cookies.

## Goals
For each tracker, show if it is running in user browser session

#### Easy
* Add gtag variable to rails `secrets`

#### Medium

* Add google `analytics.js` (only have gtag currently)
* Create our own session tracker
* Try to identify independent users (by a browser fingerprint?)

#### Medium-hard
* Mine bitcoin in user's browser (3rd-party)
* Tell a user how many times they have visited the site

#### Hard
* Mine bitcoin in user's browser (create our own)