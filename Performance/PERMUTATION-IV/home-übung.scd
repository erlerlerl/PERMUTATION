(
s.options.numOutputBusChannels = 3;
s.boot;
)
p = ProxySpace.push(t);

(
~out.ar(3);
~scl.ar(3);
~sig.ar(3);

~blc = 512;
~img_w = 480;

~fh = 48000/~blc;
~fv = 48000/~blc/~blc;
);
