function changeActiveTabAndDisplay() {
  var tabs = document.getElementsByClassName('tab');
  var tab = this;
  for (var i = 0; i < tabs.length; i++) {
    if (tabs[i].classList.contains('active')) {
      tabs[i].classList.remove('active');
    }
  }
  tab.classList.add('active');

  var tabNames = ['edit-profile', 'change-password', 'change-location'];
  tabNames.forEach(function(name) {
    var display = document.getElementById(name + '-display');
    if (tab.classList.contains(name) && display) {
      var displays = document.getElementsByClassName('info-display');
      for (var j = 0; j < displays.length; j++) {
        displays[j].style.display = 'none';
      }
      display.style.display = '';
    }
  });
}

document.addEventListener('turbolinks:load', function() {
  // add eventlistener to each tab to add active class
  var tabs = document.getElementsByClassName('tab');
  if (tabs) {
    for (var i = 0; i < tabs.length; i++) {
      tabs[i].addEventListener('click', changeActiveTabAndDisplay);
    }
  }
});