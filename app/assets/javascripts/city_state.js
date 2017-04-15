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

function setOptions(options, elem) {
  console.log(options);
  elem.setAttribute('disabled', 'true');
  elem.innerHTML = '';
  elem.removeAttribute('disabled');

  for (var i = 0; i < options.length; i++) {
    elem.innerHTML += '<option value="' + options[i][0] + '">' + options[i][1] + '</option>'; 
  }
}

document.addEventListener('DOMContentLoaded', function() {
  var countrySelect = document.getElementById('user_country');
  var stateSelect = document.getElementById('user_state');
  var citySelect = document.getElementById('user_city');

  // add options to state select input
  countrySelect.addEventListener('change', function() {
    postAjax('/city_state/state', {country: countrySelect.value}, function(options) {
      var stateSelect = document.getElementById('user_state');
      if (Object.keys(options).length > 0) {
        setOptions(options, stateSelect);
      } else {
        citySelect.removeAttribute('disabled');
        stateSelect.setAttribute('disabled', 'disabled');
        stateSelect.innerHTML = '';
      }
    });
  });

  // allow user to type in their own city after selecting state and country
  stateSelect.addEventListener('change', function() {
    if (stateSelect.value !== '' && countrySelect.value !== '') {
      citySelect.removeAttribute('disabled');
    }
  });
});