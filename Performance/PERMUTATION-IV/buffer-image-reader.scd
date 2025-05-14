// exec one line at a time
(
i = Image.new(
    // "http://supercollider.sourceforge.net/theme/sc01/icon.supercollider.gif"
    "/Users/aninsi/Desktop/WTFQs/danke-amazon.jpeg"
);
)

(
var arri, image, c_array;
image = Image.new(
    // "http://supercollider.sourceforge.net/theme/sc01/icon.supercollider.gif"
    // "/Users/aninsi/Desktop/WTFQs/danke-amazon.jpeg"
    // "/Users/aninsi/Desktop/WTFQs/michele-peace.jpeg"
    // "/Users/aninsi/Desktop/WTFQs/leonard.jpg"
    "./pipe.png"
);

arri = image.pixels();
image.loadPixels(arri);
c_array = arri.collect { |pixel, index|
  var colors = Image.pixelToColor(pixel);
  [colors.red, colors.green, colors.blue]
}.flat;

r = Buffer.loadCollection(s, c_array, 3);
)

play{Splay.ar(PlayBuf.ar(b.numChannels, b.bufnum, BufRateScale.kr(b.bufnum)))}
