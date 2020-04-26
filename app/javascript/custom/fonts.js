
// Taken from fingerprintjs2: https://github.com/Valve/fingerprintjs2
const jsFontsKey = (callback) => {
  const baseFonts = ['monospace', 'sans-serif', 'serif']

  // Just trying basic functionality for starters. Their implementation has an extended font list as well. 
  const fontList = [
    'Andale Mono', 'Arial', 'Arial Black', 'Arial Hebrew', 'Arial MT', 'Arial Narrow', 'Arial Rounded MT Bold', 'Arial Unicode MS',
    'Bitstream Vera Sans Mono', 'Book Antiqua', 'Bookman Old Style',
    'Calibri', 'Cambria', 'Cambria Math', 'Century', 'Century Gothic', 'Century Schoolbook', 'Comic Sans', 'Comic Sans MS', 'Consolas', 'Courier', 'Courier New',
    'Geneva', 'Georgia',
    'Helvetica', 'Helvetica Neue',
    'Impact',
    'Lucida Bright', 'Lucida Calligraphy', 'Lucida Console', 'Lucida Fax', 'LUCIDA GRANDE', 'Lucida Handwriting', 'Lucida Sans', 'Lucida Sans Typewriter', 'Lucida Sans Unicode',
    'Microsoft Sans Serif', 'Monaco', 'Monotype Corsiva', 'MS Gothic', 'MS Outlook', 'MS PGothic', 'MS Reference Sans Serif', 'MS Sans Serif', 'MS Serif', 'MYRIAD', 'MYRIAD PRO',
    'Palatino', 'Palatino Linotype',
    'Segoe Print', 'Segoe Script', 'Segoe UI', 'Segoe UI Light', 'Segoe UI Semibold', 'Segoe UI Symbol',
    'Tahoma', 'Times', 'Times New Roman', 'Times New Roman PS', 'Trebuchet MS',
    'Verdana', 'Wingdings', 'Wingdings 2', 'Wingdings 3'
  ]

  // we use m or w because these two characters take up the maximum width.
  // And we use a LLi so that the same matching fonts can get separated
  const testString = 'mmmmmmmmmmlli'


  // we test using 72px font size, we may use any size. I guess larger the better.
  const testSize = '72px'

  const h = document.getElementsByTagName('body')[0]

  // div to load spans for the base fonts
  const baseFontsDiv = document.createElement('div')

  // div to load spans for the fonts to detect
  const fontsDiv = document.createElement('div')

  const defaultWidth = {}
  const defaultHeight = {}



  // creates a span where the fonts will be loaded
  let createSpan = function () {
    let s = document.createElement('span')
    /*
      * We need this css as in some weird browser this
      * span elements shows up for a microSec which creates a
      * bad user experience
      */
    s.style.position = 'absolute'
    s.style.left = '-9999px'
    s.style.fontSize = testSize

    // css font reset to reset external styles
    s.style.fontStyle = 'normal'
    s.style.fontWeight = 'normal'
    s.style.letterSpacing = 'normal'
    s.style.lineBreak = 'auto'
    s.style.lineHeight = 'normal'
    s.style.textTransform = 'none'
    s.style.textAlign = 'left'
    s.style.textDecoration = 'none'
    s.style.textShadow = 'none'
    s.style.whiteSpace = 'normal'
    s.style.wordBreak = 'normal'
    s.style.wordSpacing = 'normal'

    s.innerHTML = testString
    return s
  }

  // creates a span and load the font to detect and a base font for fallback
  var createSpanWithFonts = function (fontToDetect, baseFont) {
    var s = createSpan()
    s.style.fontFamily = "'" + fontToDetect + "'," + baseFont
    return s
  }

  // creates spans for the base fonts and adds them to baseFontsDiv
  var initializeBaseFontsSpans = function () {
    var spans = []
    for (var index = 0, length = baseFonts.length; index < length; index++) {
      var s = createSpan()
      s.style.fontFamily = baseFonts[index]
      baseFontsDiv.appendChild(s)
      spans.push(s)
    }
    return spans
  }

  // creates spans for the fonts to detect and adds them to fontsDiv
  var initializeFontsSpans = function () {
    var spans = {}
    for (var i = 0, l = fontList.length; i < l; i++) {
      var fontSpans = []
      for (var j = 0, numDefaultFonts = baseFonts.length; j < numDefaultFonts; j++) {
        var s = createSpanWithFonts(fontList[i], baseFonts[j])
        fontsDiv.appendChild(s)
        fontSpans.push(s)
      }
      spans[fontList[i]] = fontSpans // Stores {fontName : [spans for that font]}
    }
    return spans
  }

  // checks if a font is available
  var isFontAvailable = function (fontSpans) {
    var detected = false
    for (var i = 0; i < baseFonts.length; i++) {
      detected = (fontSpans[i].offsetWidth !== defaultWidth[baseFonts[i]] || fontSpans[i].offsetHeight !== defaultHeight[baseFonts[i]])
      if (detected) {
        return detected
      }
    }
    return detected
  }

  // create spans for base fonts
  var baseFontsSpans = initializeBaseFontsSpans()

  // add the spans to the DOM
  h.appendChild(baseFontsDiv)

  // get the default width for the three base fonts
  for (var index = 0, length = baseFonts.length; index < length; index++) {
    defaultWidth[baseFonts[index]] = baseFontsSpans[index].offsetWidth // width for the default font
    defaultHeight[baseFonts[index]] = baseFontsSpans[index].offsetHeight // height for the default font
  }

  // create spans for fonts to detect
  var fontsSpans = initializeFontsSpans()

  // add all the spans to the DOM
  h.appendChild(fontsDiv)

  // check available fonts
  var available = []
  for (var i = 0, l = fontList.length; i < l; i++) {
    if (isFontAvailable(fontsSpans[fontList[i]])) {
      available.push(fontList[i])
    }
  }

  // remove spans from DOM
  h.removeChild(fontsDiv)
  h.removeChild(baseFontsDiv)
  callback(available)

};

module.exports = jsFontsKey;