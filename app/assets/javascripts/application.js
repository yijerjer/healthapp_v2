// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .

// custom pure js animation functions
function fadeIn(el) {
  el.style.opacity = 0;
  el.style.display = 'block';

  var tick = function() {
    el.style.opacity = +el.style.opacity + 0.08;

    if (+el.style.opacity < 1) {
      requestAnimationFrame(tick) || setTimeout(tick, 16);
    }
  };
  tick();
}

function fadeOut(el) {
  el.style.opacity = 1;

  var tick = function() {
    el.style.opacity = +el.style.opacity - 0.08;

    if (+el.style.opacity > 0) {
      requestAnimationFrame(tick);
    }
  };
  tick();
  setTimeout(function() {
    el.style.display = 'none';
  }, 500);
}