// PROXYSPACE <- TEMPOCLOCK
(
p = ProxySpace.push(s);
p.makeTempoClock;
p.clock; // now the ProxySpace's clock is a TempoBusClock
p.clock.tempo = 120 / 240;
)

// PROXYSPACE SETTINGS
(
p.fadeTime = 0.5;
p.quant = 1;
)

// NODES
(
// SYNTHS
~r.ar(1);
~g.ar(1);
~b.ar(1);

// VARIABLES
~sr.ar(1); // SAMPLERATE
~bl.ar(1); // BLOCKSIZE
~si.ar(1); // SIZE (= WIDTH = HEIGHT)
~fs.ar(1); // FRAMES PER SECOND
~co.ar(1); // COLORS
~sc.ar(1); // SCROLLSPEED
)

// VARIABLES INIT
(
~sr = 48000; // SAMPLERATE
~bl = 512; // BLOCKSIZE
~si = 512; // SIZE
~fs = 30; // FRAMES PER SECOND
~co = 6; // COLORS
~sc = ~sr.kr / ~bl.kr * (~co.kr / 3); // SCROLLSPEED
)
