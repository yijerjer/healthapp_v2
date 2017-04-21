document.addEventListener('DOMContentLoaded', function() {
  // change navbar background to black after background disappears
  var background = document.getElementsByClassName('bg-img-home')[0];
  if (background) {
    window.addEventListener('scroll', function() {
      var nav = document.getElementsByClassName('navbar')[0];
      var navStyle = window.getComputedStyle(nav);

      if (document.body.scrollTop > background.scrollHeight - parseInt(navStyle.height)) {
        nav.style.background = '#000';
      } else {
        nav.style.background = '';
      }
    });
  }
});