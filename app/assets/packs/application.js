// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.


// Stylesheets
import "../stylesheets/application.sass"
import "../stylesheets/custom.sass"
import "bootstrap/scss/bootstrap-reboot.scss"
import "bootstrap/scss/bootstrap.scss"
require.context('../stylesheets/blocks', true, /\.sass$/)

// Images
import "feather-icons/dist/feather-sprite.svg"
require.context('../images', true, /\.(?:png|jpg|gif|ico|svg)$/)


// Javascript
import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "javascript/channels"
import "unpoly"
let webpackContext = require.context('../javascript', true, /\.js$/)
for(let key of webpackContext.keys()) { webpackContext(key) }

Rails.start()
ActiveStorage.start()
