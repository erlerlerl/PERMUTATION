~sig.fadeTime = 30;
~sig.fadeTime = 0;

~sig = {};
(
~sig = {
  arg bufnum = 0, scale = 1, loop = 0;
  var snd,
    start = 90000,
    end = BufFrames.kr(bufnum) * (3/4),
    rate = (1/2.0);
    // rate = Line.ar(1/64, 1, 30);
    // rate = (1/2.00001);
    // rate = (1/4.0);
    // rate = (1/8.0);
    // rate = (1/16.0);
    // rate = (1/50.0);

  // snd = PlayBuf.ar(3, bufnum, (~img_w/~blc) / rate * LFPulse.ar(1/10.8/8).linlin(0,1,-1,1).lag, startPos: 90000, trigger: Impulse.ar(1/2));
  // snd = PlayBuf.ar(3, bufnum, (~img_w/~blc) / rate * LFPulse.ar(1/10.8/4).linlin(0,1,-1,1).lag, startPos: 90000, trigger: Impulse.ar(1/10.8));
  snd = BufRd.ar(3, bufnum, Phasor.ar(0, BufRateScale.kr(bufnum) * (~img_w/~blc) * rate, start, end), loop, 1);
  // snd = BufRd.ar(3, bufnum, LFSaw.ar((1/BufDur.kr(bufnum)) * (~img_w/~blc) * rate, 1).range(0, BufFrames.kr(bufnum)), loop, 1);
  // snd = BufRd.ar(3, bufnum, LFSaw.ar((1/BufDur.kr(bufnum)) * (~img_w/~blc) * rate, 1).range(start, end), loop, 1);

  // snd = snd + (0.5 * WhiteNoise.ar);

  // SCALING
  snd = Select.ar(scale, [snd, snd.linlin(0,1,-1,1), -1 * snd, snd.linlin(0,1,-1,1).round(1)]);

  snd.flat;
});

~out.fadeTime = 60;
~out.fadeTime = 30;
~out.fadeTime = 20;
~out.fadeTime = 5;
~out.fadeTime = 2;
~out.fadeTime = 0;

~out = {};

~out = { ~sig.ar };

~out = { BLowPass.ar(~sig.ar, ~fh*(1/8), 0.5) * 0.5 };
~out = { BLowPass.ar(~sig.ar, ~fh*(1/8), 0.5) };
~out = { BLowPass.ar(~sig.ar, ~fh*(1/9), 0.1) };
~out = { BLowPass.ar(~sig.ar, ~fh*(1/4), 0.08) };
~out = { BLowPass.ar(~sig.ar, ~fh*(1/3), 0.08).tanh };
~out = { BLowPass.ar(~sig.ar, ~fh*(1/2), 0.008) * 0.3 }; // <-- arrive here - RATE OF BUFFER MUST BE 2!
~out = { BLowPass.ar(~sig.ar, ~fh*(1/2), 0.1) * 0.5 };
~out = { BLowPass.ar(~sig.ar, ~fh*(1/1.8), 0.08) };
~out = { BLowPass.ar(~sig.ar, ~fh*(1/1.5), 0.008) };
~out = { BLowPass.ar(~sig.ar, ~fh*(1/2.0), 0.002) * 0.2 };
~out = { BLowPass.ar(~sig.ar, ~fh*(1/2.0), [0.002, 0.001, 0.03]) * 0.2 };
~out = { BLowPass.ar(~sig.ar, ~fh*(1/2.1), 0.002) * 0.2 };
~out = { BLowPass.ar(~sig.ar, ~fh*(1/2.05), 0.002) * 0.2 };
~out = { BLowPass.ar(~sig.ar, ~fh*(1/2.0), 0.002).round(0.1) * 0.2 };
~out = { BLowPass.ar(~sig.ar, ~fh*(1/2.0), 0.002).round(0.5) * 0.2 };
~out = { BLowPass.ar(~sig.ar, ~fh*(1), 0.08) * 0.3 };
~out = { BLowPass.ar(~sig.ar, ~fh*(2), 0.01) * 0.05 };
~out = { BLowPass.ar(~sig.ar, ~fh*(3.3), 0.01) * 0.05 };

~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*(1/3), 0.001) * 0.4, ~fh*(1/2), 0.08).tanh * 0.2 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*(1/LFDNoise3.ar(1/3).range(2,4).round(0.3)), [0.001, 0.02, 0.1]) * 0.4, ~fh*(1/2), [0.08, 0.001, 0.01]).tanh * 0.4 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*(1/LFDNoise3.ar(1/4).range(2,8).round(2).lag(0.4)), [0.001, 0.02, 0.1]) * 0.4, ~fh*(1/2), [0.08, 0.04, 0.01]).tanh * 0.3 };

~out = { BHiPass.ar(~sig.ar, ~fh*(1/2), 0.05) * 0.5 };
~out = { BHiPass.ar(~sig.ar, ~fh*(1/2), 0.03) * 0.5 };
~out = { BHiPass.ar(~sig.ar, ~fh*(1/2), 0.01) * 0.3 };
~out = { BHiPass.ar(~sig.ar, ~fh*(1/2), 0.002) * 0.2 };
~out = { BHiPass.ar(~sig.ar, ~fh*(1/2), [0.002, 0.1, 0.1]).tanh * 0.3 };
// FADE BETWEEN ↑ & ↓
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*(1/2), 0.008) * 0.5, ~fh*(4), 0.1) * 0.4 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*(1/2), 0.008) * 0.5, ~fh*(7.3), 0.1) * 0.35 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*(1/2), 0.008) * 0.5, ~fh*(16), 0.1) * 0.25 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*(1/2), 0.008) * 0.5, ~fh*(29.3), 0.1) * 0.22 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*(1/2), 0.008) * 0.5, ~fh*([16, 32.5, 29.3]), 0.1) * 0.2 };
~out = { BHiPass.ar(~sig.ar, ~fh*(1/2) * {LFDNoise3.ar(LFDNoise1.ar(1/2).range(1/4, 1)).linexp(-1,1,0.99999,1.00001)}.dup(3), 0.01) * 0.28 };

// AMBIENT WITH PITCHES
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.01), LFDNoise3.ar(2).linexp(-1,1,800,12000).round(~fh * 3), [0.001, 0.1, 0.4]) * 0.002 };

// AMBIENT
// FADE IN
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.0001), {LFDNoise0.ar(LFDNoise0.ar(6).linlin(-1,1,2,4)).linexp(-1,1,800,12000).round(~fh * 12)}.dup(3), 0.002) * 0.0005 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.0001), {LFDNoise0.ar(LFDNoise0.ar(6).linlin(-1,1,2,4)).linexp(-1,1,800,12000).round(~fh * 12)}.dup(3), 0.002) * 0.0008 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.0001), {LFDNoise0.ar(LFDNoise0.ar(6).linlin(-1,1,2,4)).linexp(-1,1,800,12000).round(~fh * 12)}.dup(3), 0.002) * 0.002 };

~out = { (BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.0001), {LFDNoise0.ar(LFDNoise0.ar(6).linlin(-1,1,2,4)).linexp(-1,1,800,12000).round(~fh * 12)}.dup(3), 0.002) * 0.0004) + (0.2 * BLowPass4.ar(~sig.ar, ~fh*(1/2), 0.5)) };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.0004), {LFDNoise0.ar(LFDNoise0.ar(6).linlin(-1,1,2,4)).linexp(-1,1,800,12000).round(~fh * 2.6)}.dup(3), 0.002) * 0.0004 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.0001), {LFDNoise0.ar(LFDNoise0.ar(6).linlin(-1,1,2,4)).linexp(-1,1,800,12000).round(~fh * 13)}.dup(3), 0.002) * 0.0004 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.0001), {LFDNoise0.ar(LFDNoise0.ar(6).linlin(-1,1,2,4)).linexp(-1,1,800,12000).round(~fh * 13.3)}.dup(3), 0.002) * 0.0004 };
// !!!!!!!!!!!!!!!!!!
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.0001), {LFDNoise0.ar(LFDNoise0.ar(6).linlin(-1,1,2,4)).linexp(-1,1,800,12000).round(~fh * 14)}.dup(3), 0.002) * 0.004 };

// END
(
~sig = {
  arg bufnum = 0, scale = 0, loop = 0;
  var snd, env,
    time = 90,
    start = 90000,
    end = BufFrames.kr(bufnum) * (4/5),
    rate = Env([1/128, 1/2], [time], [-2, \hold]).ar;

  env = Env([1,0], time + 5, \hold).ar(2);

  snd = BufRd.ar(3, bufnum, Phasor.ar(0, BufRateScale.kr(bufnum) * (~img_w/~blc) * rate, start, end), loop, 1);
  snd = snd * env;

  // SCALING
  snd = Select.ar(scale, [snd, snd.linlin(0,1,-1,1), -1 * snd, snd.linlin(0,1,-1,1).round(1)]);

  snd.flat;
};

~out = { (BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.0001), {LFDNoise0.ar(LFDNoise0.ar(6).linlin(-1,1,2,4)).linexp(-1,1,800,12000).round(~fh * 12)}.dup(3), 0.002) * 0.0004 * Env([1,0], 90).ar) + ((0.005 * BLowPass4.ar(~sig.ar, ~fh * [2, 4, 8] * 4, 0.2) + (~sig.ar * 0.001)) * Env([0,12.5, 0], [90, 2], -2).ar) }
);

~out.play(b.index);
