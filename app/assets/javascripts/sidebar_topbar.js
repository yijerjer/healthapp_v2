document.addEventListener('turbolinks:load', function() {
  (function() {
    var sidebar = document.getElementById('sidebar');
    var hamburger = document.querySelector('#topbar .fa-bars');
    var arrowLeft = document.querySelector('#sidebar .fa-arrow-left');
    var darkenOverlay = document.getElementById('darken-overlay');

    function toggleSidebar() {
      hamburger.addEventListener('click', function() {
        sidebar.style.left = '0';
        // darkenOverlay.style.display = 'block';
        fadeIn(darkenOverlay);
      });
      arrowLeft.addEventListener('click', function() {
        sidebar.style.left = '-80%';
        fadeOut(darkenOverlay);
      });
      darkenOverlay.addEventListener('click', function() {
        sidebar.style.left = '-80%';
        fadeOut(darkenOverlay);
      });
    }    
    
    toggleSidebar();
  }) ();

});