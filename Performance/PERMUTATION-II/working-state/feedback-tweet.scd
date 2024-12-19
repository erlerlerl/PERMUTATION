(
p = ProxySpace.push(s);
)

p.fadeTime = 10;


(
~xai.ar(2);
~nai.ar(2);
)

~xai = { SinOsc.ar(~xai.ar.linlin(-1,1,80,LFNoise0.kr(4).linlin(-1,1,100,2000))) * LFNoise1.ar(20) * 1.0 };
~xai.play;
~xai.stop;
~nai = { (Saw.ar(~xai.ar.linlin(-1,1,1/3,10) * ~nai.ar + 1) - 1).tanh }
~nai.play;
~nai.stop;
