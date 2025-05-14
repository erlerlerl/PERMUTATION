// CLIENT
(
o = ServerOptions.new;
// o.maxLogins = 2;
o.protocol_(\tcp);
t = Server.remote(\remote, NetAddr("10.0.1.52", 57110), o); // SET TO CORRECT ADDRESS AND PORT
t.addr.connect;
t.startAliveThread(0);
t.doWhenBooted({"remote tcp server started".postln; t.notify; t.initTree});
t.makeWindow;
// PROXY SPACE
p = ProxySpace.push(t);
)

(
~mix.ar(3);
~sig.ar(3);
~pan.ar(3);
~panner.ar(1);
~pitch.ar(3);

~fh = 48000/512;
~fv = 48000/512/512;
)

// BUS
(
b = Bus.audio(t, 3);
b.index.postln;
~pitch_bus = Bus.audio(t, 3);
~pitch_bus.index.postln;
)
