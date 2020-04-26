const jsFontsKey = require("custom/fonts");

window.dataLayer = window.dataLayer || [];
// eslint-disable-next-line no-undef
function gtag(){dataLayer.push(arguments)}
gtag('js', new Date());

gtag('config', 'UA-158940829-2');


function userInformation(callback) {
  const plugins = []
  for (let i = 0; i < window.navigator.plugins.length; i++) {
    let plugin = window.navigator.plugins[i];
    plugins.push(plugin.name + "; " + plugin.description + "; " + plugin.filename + "; ");
  }

  jsFontsKey((available) => {
    callback({
      width: screen.width,
      height: screen.height,
      depth: screen.pixelDepth,
      timezone: new Date().getTimezoneOffset(),
      plugins: plugins,
      fonts: available,
    });
  });
}