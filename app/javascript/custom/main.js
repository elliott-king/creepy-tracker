const jsFontsKey = require("custom/fonts");

window.dataLayer = window.dataLayer || [];
// eslint-disable-next-line no-undef
function gtag(){dataLayer.push(arguments)}
gtag('js', new Date());

gtag('config', 'UA-158940829-2');

window.onload = () => {
  userInformation((userInfo) => {
    // Introduction to AJAX requests: https://www.w3schools.com/xml/ajax_intro.asp
    let xhttp = new XMLHttpRequest();
    const url = "/users";
    xhttp.open("POST", url);

    // Adding JSON to XMLHttpRequest: https://stackoverflow.com/questions/39519246
    xhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");

    // JS for Rails auth token: https://stackoverflow.com/questions/7560837
    const token = document.querySelector('meta[name="csrf-token"]').content
    xhttp.setRequestHeader('X-CSRF-Token', token)
    xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            document.querySelector('#response-container').innerHTML = this.response;
       }
    };
    xhttp.send(JSON.stringify({fingerprint: userInfo}));
  });
}

function userInformation(callback) {
  const plugins = []
  for (let i = 0; i < window.navigator.plugins.length; i++) {
    let plugin = window.navigator.plugins[i];
    plugins.push(plugin.name + "; " + plugin.description + "; " + plugin.filename + "; ");
  }
  plugins.sort(); // EFF sorts this to reduce entropy

  jsFontsKey((available) => {
    callback({
      width: screen.width,
      height: screen.height,
      depth: screen.pixelDepth,
      timezone: new Date().getTimezoneOffset().toString(),
      plugins: plugins.toString(),
      fonts: available.toString(),
    });
  });
}