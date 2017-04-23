// ajax call to city_state#country
function postAjax(url, countryStateObject, callbackFunction) {
  var xhttp = new XMLHttpRequest();
  xhttp.open("POST", url, true);

  xhttp.setRequestHeader('Content-type', 'application/json');

  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      var option =  JSON.parse(this.response);
      callbackFunction(option);
    }
  };

  xhttp.send(JSON.stringify(countryStateObject));
}

// append options to select html input
function setOptions(options, elem) {
  elem.setAttribute('disabled', 'true');
  elem.innerHTML = '';

  for (var i = 0; i < options.length; i++) {
    elem.innerHTML += '<option value="' + options[i][0] + '">' + options[i][1] + '</option>'; 
  }
}

document.addEventListener('turbolinks:load', function() {
  var countrySelect = document.getElementsByClassName('country-select')[0];
  var stateSelect = document.getElementsByClassName('state-select')[0];
  var citySelect = document.getElementsByClassName('city-select')[0];

  if (countrySelect && stateSelect && citySelect) {
    // add options to state select input
    countrySelect.addEventListener('change', function() {
      postAjax('/city_state/state', {country: countrySelect.value}, function(options) {
        if (Object.keys(options).length > 0) {
          setOptions(options, stateSelect);
          elem.removeAttribute('disabled');
        } else {
          citySelect.removeAttribute('disabled');
          stateSelect.setAttribute('disabled', 'true');
          stateSelect.innerHTML = '';
        }
      });
    });

    // allow user to type in their own city after selecting state and country
    // remove disabled property for the input
    stateSelect.addEventListener('change', function() {
      if (stateSelect.value !== '' && countrySelect.value !== '') {
        citySelect.removeAttribute('disabled');
      }
    });
  }
});