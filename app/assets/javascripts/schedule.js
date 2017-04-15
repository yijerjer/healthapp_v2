function showHideLocationFields() {
  if (this.checked) {
    document.getElementsByClassName('location-fields')[0].style.visibility = 'hidden';
  } else {
    document.getElementsByClassName('location-fields')[0].style.visibility = 'visible';
  }
}

document.addEventListener('DOMContentLoaded', function() {
  var locationCheckBox = document.getElementById('schedule_use_user_location');
  locationCheckBox.addEventListener('change', showHideLocationFields);
});