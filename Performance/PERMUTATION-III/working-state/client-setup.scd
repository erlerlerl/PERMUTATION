// CLIENT
(
o = ServerOptions.new;
o.maxLogins = 2;
o.protocol_(\tcp);
t = Server.remote(\remote, NetAddr("169.254.232.238", 57110), o); // set to correct address and port
t.addr.connect;
t.startAliveThread( 0 );
t.doWhenBooted({ "remote tcp server started".postln; t.notify; t.initTree });
t.makeWindow;
)

