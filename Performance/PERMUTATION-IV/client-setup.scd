// CLIENT
(
o = ServerOptions.new;
// o.maxLogins = 2;
o.protocol_(\tcp);
t = Server.remote(\remote, NetAddr("169.254.28.93", 57110), o); // SET TO CORRECT ADDRESS AND PORT
t.addr.connect;
t.startAliveThread(0);
t.doWhenBooted({"remote tcp server started".postln; t.notify; t.initTree});
t.makeWindow;
// PROXY SPACE
p = ProxySpace.push(t);
)

(
(
~out.ar(3);
~scl.ar(3);
~sig.ar(3);

~blc = 512;
~img_w = 480;

~fh = 48000/~blc;
~fv = 48000/~blc/~blc;
);

// BUS
(
b = Bus.audio(t, 3);
b.index.postln;
~pitch_bus = Bus.audio(t, 3);
~pitch_bus.index.postln;
)
)
