// SERVER
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

// PROXY SPACE
p = ProxySpace.push(t);

(
~xai.ar(3);
~nai.ar(3);

~fh = 96000/400;
~fv = 96000/400/400;
)

// BUS
(
b = Bus.audio(t, 3);
b.index;
)

////// TEST
~xai = { SinOsc.ar(~fh) };

// AUDIO
p.fadeTime = 1;

// DONT CHANGE
~xai = { {SinOsc.ar(~xai.ar.linlin(-1,1,80,LFNoise0.kr(4).linlin(-1,1,100,2000))) * LFNoise1.ar(20)} * 0.0 };
~xai = { {SinOsc.ar(~xai.ar.linlin(-1,1,80,LFNoise0.kr(4).linlin(-1,1,100,2000))) * LFNoise1.ar(20)} * 1.0 };

~xai.play(b.index);
~xai.stop;
~xai.clear;
// DONT CHANGE

~xai = { {SinOsc.ar(~xai.ar.linlin(-1,1,80,LFNoise0.kr(4).linlin(-1,1,100,2000))) * LFNoise1.ar(20)} * 1.0 };
~xai = { {SinOsc.ar(~xai.ar.linlin(-1,1,80,LFNoise0.kr(4).linlin(-1,1,~fh/64,~fh*32))) * LFNoise1.ar(~fv*128)} * 1.0 };

~xai = { {SinOsc.ar(~xai.ar.linlin(-1,1,80,LFNoise0.kr(4).linlin(-1,1,~fh/128,~fh*32))) * LFNoise1.ar(~fv*128)} * 1.0 };
~xai = { {SinOsc.ar(~xai.ar.linlin(-1,1,80,LFNoise0.kr(4).linlin(-1,1,~fh/128,~fh/2))) * LFNoise1.ar(~fv*128)} * 1.0 };

~xai = { {SinOsc.ar(~xai.ar.linlin(-1,1,80,LFNoise0.kr(4).linlin(-1,1,~fh/64,~fh*64))) * LFNoise1.ar(16)} * 1.0 };

~xai = { {SinOsc.ar(~xai.ar.linlin(-1,1,80,LFNoise0.kr(4).linlin(-1,1,~fh/256,~fh*1024))) * LFNoise1.ar(~fv*64)} * 1.0 };
~xai = { {SinOsc.ar(~xai.ar.linlin(-1,1,80,LFNoise0.kr(4).linlin(-1,1,~fh/256,~fh*8))) * LFNoise1.ar(~fv*32)} * 1.7 };

// FADE BETWEEN HIGH AND LOW
~xai = { {SinOsc.ar(~xai.ar.linlin(-1,1,80,LFNoise0.kr(4).linlin(-1,1,~fh/128,~fh*256))) * LFNoise1.ar(~fv*16)} * 1.7 };
~xai = { {SinOsc.ar(~xai.ar.linlin(-1,1,80,LFNoise0.kr(4).linlin(-1,1,~fh/256,~fh/64))) * LFNoise1.ar(~fv*4024)} * 1.7 };

~xai = { {SinOsc.ar(~xai.ar.linlin(-1,1,80,LFNoise0.kr(4).linlin(-1,1,~fh/16,~fh*64))) * LFNoise1.ar(~fv/8)} * 2.0 };
~xai = { {SinOsc.ar(~xai.ar.linlin(-1,1,80,LFNoise0.kr(4).linlin(-1,1,~fh/256,~fh*1024))) * LFNoise1.ar(~fv*30)} * 2.0 };
~xai = { {SinOsc.ar(~xai.ar.linlin(-1,1,80,LFNoise0.kr(4).linlin(-1,1,~fh/16,~fh*64))) * LFNoise1.ar(~fh/16)} * 2.0 };

// nai
// DONT CHANGE
~nai = { (Saw.ar(~xai.ar.linlin(-1,1,1/3,10) * ~nai.ar + 1) - 1).tanh * 0.0 };
~nai = { (Saw.ar(~xai.ar.linlin(-1,1,1/3,10) * ~nai.ar + 1) - 1).tanh * 1.0 };

~nai.play(b.index);
~nai.stop;
~nai.clear;
// DONT CHANGE

~nai = { (Saw.ar(~xai.ar.linlin(-1,1,1/3,10) * ~nai.ar + 1) - 1).tanh * 1.0 };
~nai = { (Saw.ar(~xai.ar.linlin(-1,1,1/3,~fv) * ~nai.ar + 1) - 1).tanh * 1.0 };

// ACT FREE
p.fadeTime = 20;
p.fadeTime = 1;
~nai = { (Saw.ar(~xai.ar.linlin(-1,1,1/6,~fv/16) * ~nai.ar + 1) - 1).tanh * 1.0 };
~nai = { (Saw.ar(~xai.ar.linlin(-1,1,1/3,~fv*1) * ~nai.ar + 1) - 1).tanh * 1.0 };
~nai = { (Saw.ar(~xai.ar.linlin(-1,1,1/3,~fv*2) * ~nai.ar + 2) - 1).tanh * 1.0 };
~nai = { (Saw.ar(~xai.ar.linlin(-1,1,1/3,~fv*2) * ~nai.ar + 4) - 1).tanh * 1.0 };
~nai = { (Saw.ar(~xai.ar.linlin(-1,1,1/3,~fv*2) * ~nai.ar + 8) - 1).tanh * 1.0 };
~nai = { (Saw.ar(~xai.ar.linlin(-1,1,1/3,~fv*2) * ~nai.ar + 10) - 1).tanh * 1.0 };
~nai = { (Saw.ar(~xai.ar.linlin(-1,1,1/3,~fv*2) * ~nai.ar + 12) - 1).tanh * 1.0 };
~nai = { (Saw.ar(~xai.ar.linlin(-1,1,1/3,~fv*2) * ~nai.ar + 16) - 1).tanh * 1.0 };
~nai = { (Saw.ar(~xai.ar.linlin(-1,1,1/3,~fv*4) * ~nai.ar + 16) - 1).tanh * 1.0 };
~nai = { (Saw.ar(~xai.ar.linlin(-1,1,1/3,~fv*4) * LFNoise0.kr(0.5).linlin(-1,1,1,2) * ~nai.ar + 16) - 1).tanh * 1.0 };
~nai = { (Saw.ar({~xai.ar.linlin(-1,1,1/3,~fv*256) * ~nai.ar + 4}!3) - 1).tanh * 1.0 };
~nai = { (Saw.ar({~xai.ar.linlin(-1,1,1/3,~fv*512) * ~nai.ar + 4}!3) - 1).tanh * 1.0 };
~nai = { (Saw.ar({~xai.ar.linlin(-1,1,1/3,~fv*1024) * ~nai.ar + 4}!3) - 1).tanh * 1.0 };

// 1 MINUTE INTRO
// 1 MINUTE OVERLEITUNG
// 1 MINUTE RICO DELAYED (Minute 3) --> ich chille
// 1 MINUTE ich chille nicht mehr >:(
// ich chill wieder n bisschen mehr(minute 5 / 6)
// Minute 7 & 8 bring langsam ~nai rein, ACT FREE
// OUTRO
