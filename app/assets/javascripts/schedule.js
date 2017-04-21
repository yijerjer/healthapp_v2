// to hide/show location fields in schedule#new page - if the user selects use own city
function showHideLocationFields() {
  if (this.checked) {
    document.getElementsByClassName('location-fields')[0].style.visibility = 'hidden';
  } else {
    document.getElementsByClassName('location-fields')[0].style.visibility = 'visible';
  }
}

document.addEventListener('DOMContentLoaded', function() {
  var locationCheckBox = document.getElementById('schedule_use_user_location');
  if (locationCheckBox) {
    locationCheckBox.addEventListener('change', showHideLocationFields);
  }
});