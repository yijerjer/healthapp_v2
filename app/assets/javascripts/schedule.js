// to hide/show location fields in schedule#new page - if the user selects use own city
function setValueFromOptions(select, innerHTML) {
  var value;

  for (var i = 0; i < select.children.length; i++) {
    if (select.children[i].innerHTML === innerHTML) {
      value = select.children[i].value;
      break;
    }
  }

  select.value = value;
}

function toggleUserLocation() {
  var countrySelect = document.getElementById('schedule_country');
  var stateSelect = document.getElementById('schedule_state');
  var citySelect = document.getElementById('schedule_city');
  var locationFields = [countrySelect, stateSelect, citySelect];

  countrySelect.addEventListener('change', function() {
    console.log('changed');
  });

  if (this.checked) {
    // set the values of the locations
    setValueFromOptions(countrySelect, this.dataset.country);
    // function calls from city_state.js to add options to stateSelect 
    postAjax('/city_state/state', {country: countrySelect.value}, function(options) {
      if (Object.keys(options).length > 0) {
        setOptions(options, stateSelect);
      }
    });
    setValueFromOptions(stateSelect, this.dataset.state);
    citySelect.value = this.dataset.city;

    for (var i = 0; i < locationFields.length; i++) {
      locationFields[i].setAttribute('disabled', 'true');
    }
  } else {
    for (var i = 0; i < locationFields.length; i++) {
      locationFields[i].removeAttribute('disabled');
    }
  }
}

document.addEventListener('turbolinks:load', function() {
  var locationCheckBox = document.getElementById('schedule_use_user_location');
  if (locationCheckBox) {
    locationCheckBox.addEventListener('change', toggleUserLocation);
  }
});