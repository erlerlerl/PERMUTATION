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

(
var addresses;

Public.startListen;	// start an osc responder to dispatch the messages
addresses = [NetAddr("169.254.57.94", 57120)]; // this is loopback for now. Port must be 57120 (sc-lang)

b = ProxySpace(t);
// create two new environment redirect (works basically like an environment)
b.dispatch = d;

// set their dispatch variables. the envir is registered in the dispatch implicitly
d = Public(b);	// create 2 new instances (one "remote" one "local")
d.addresses = addresses; // set the addresses - this can be done at any time laterto add new ones.

d.join(\waitingroom, \maxi);
d.sendingKeys = \all;
d.listeningKeys = \all;
)

b;


b[\xai].play;
b[\aii] = 5
b[\xai] = { SinOsc.ar(60) };
