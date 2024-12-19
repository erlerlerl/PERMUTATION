t = TempoClock.new(100/60, 4);
p = ProxySpace.push(s, clock: t);

~hat.ar(2);
~hat.play;
~hat.stop;

~hat = { Env.perc(0.01, 0.02).ar(0, ~trig1.ar(3)) * WhiteNoise.ar(0.4) }

~trig1.ar(2);
~trig1.play;
~trig1.stop;

~trig1 = { Impulse.ar([t.beatDur * 7, t.beatDur * 3]) };

~kick.ar(2);
~kick.play;

~kick = { Ringz.ar(~trig2.ar(2), 46.midicps, 0.4, 1) * 0.4 }

~trig2.ar(2);
~trig2.play;
~trig2.stop;

~trig2 = { Impulse.ar([t.beatDur * 8, t.beatDur * 3]).lag(0.01) };

