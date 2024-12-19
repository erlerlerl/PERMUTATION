(
o = ServerOptions.new;
o.maxLogins = 2;
o.protocol_(\tcp);
t = Server.remote(\remote, NetAddr("169.254.57.94", 57110), o); // set to correct address and port
t.addr.connect;
t.startAliveThread( 0 );
t.doWhenBooted({ "remote tcp server started".postln; t.notify; t.initTree });
t.makeWindow
)

p = ProxySpace.push(t)
ProxySpace.findSpace(t)
p

n = NodeProxy.audio(t, 3)

n = {Saw.ar([60,80,35]) * 0.1}

n.source = {SinOsc.ar([60,80,35] * SinOsc.ar([1/10, 1/5, 1/20] * 2000).linlin(-1.0,1.0,1.0,4.0)) * 0.1}

n.play
n.stop

n.nodeID

t.status

~xai.ar(3)
~xai[0] = { LFGauss.ar(1/[60,80,35]) * 0.1 }
~xai.play(t)
~xai.stop(t)

EnvirGui.new()

{ SinOsc.ar([50, 60, 70]) * 0.5 }.play(t)

Public
