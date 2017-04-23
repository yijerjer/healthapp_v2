document.addEventListener('turbolinks:load', function() {
  var alert = document.getElementsByClassName('alert')[0];
  var timeoutVar = setTimeout(function() { fadeOut(alert); }, 7000);

  // remove timeout when mouse is inside the alert div, reinstate timeout after
  alert.addEventListener('mouseenter', function() {
    console.log('enter');
    clearTimeout(timeoutVar);
  });
  alert.addEventListener('mouseleave', function() {
    timeoutVar = setTimeout(function() { fadeOut(alert); }, 7000);
  });

  var closeIcon = alert.getElementsByTagName('i')[0];
  closeIcon.addEventListener('click', function() {
    fadeOut(alert);
  });
});