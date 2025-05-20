~sig.fadeTime = 30;
~sig.fadeTime = 0;

~sig = {};
(
~sig = {
  arg bufnum = 0, scale = 1, loop = 0;
  var snd,
    start = 90000,
    end = BufFrames.kr(bufnum) * (3/4),
    rate = (1/1.5);

  snd = BufRd.ar(3, bufnum, Phasor.ar(0, BufRateScale.kr(bufnum) * (~img_w/~blc) * rate, start, end), loop, 1);
  // snd = BufRd.ar(3, bufnum, LFSaw.ar((1/BufDur.kr(bufnum)) * (~img_w/~blc) * rate, 1).range(0, BufFrames.kr(bufnum)), loop, 1);
  // snd = BufRd.ar(3, bufnum, LFSaw.ar((1/BufDur.kr(bufnum)) * (~img_w/~blc) * rate, 1).range(start, end), loop, 1);

  // SCALING
  snd = Select.ar(scale, [snd, snd.linlin(0,1,-1,1), -1 * snd, snd.linlin(0,1,-1,1).round(1)]);

  snd.flat;
});

~out.fadeTime = 60;
~out.fadeTime = 20;
~out.fadeTime = 0;

~out = {};

~out = { ~sig.ar };

~out = { BHiPass.ar(~sig.ar, ~fh*(1/2), 0.05) * 0.5 };
~out = { BHiPass.ar(~sig.ar, ~fh*(1/2), 0.03) * 0.5 };
~out = { BHiPass.ar(~sig.ar, ~fh*(1/2), 0.01) * 0.3 };
~out = { BHiPass.ar(~sig.ar, ~fh*(1/2), 0.002) * 0.2 };
// FADE BETWEEN ↑ & ↓
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*(1/2), 0.008) * 0.5, ~fh*(4), 0.1) * 0.4 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*(1/2), 0.008) * 0.5, ~fh*(7.3), 0.1) * 0.35 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*(1/2), 0.008) * 0.5, ~fh*(16), 0.1) * 0.25 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*(1/2), 0.008) * 0.5, ~fh*(29.3), 0.1) * 0.22 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*(1/2), 0.008) * 0.5, ~fh*([16, 32.5, 29.3]), 0.1) * 0.2 };
~out = { BHiPass.ar(~sig.ar, ~fh*(1/2) * {LFDNoise3.ar(LFDNoise1.ar(1/2).range(1/4, 1)).linexp(-1,1,0.99999,1.00001)}.dup(3), 0.01) * 0.28 };

// AMBIENT
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.01), LFDNoise3.ar(2).linexp(-1,1,800,12000).round(~fh * 3), [0.001, 0.1, 0.4]) * 0.002 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.0001), {LFDNoise0.ar(LFDNoise0.ar(6).linlin(-1,1,2,4)).linexp(-1,1,800,12000).round(~fh * 12)}.dup(3), 0.002) * 0.003 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.00004), {LFDNoise0.ar(LFDNoise0.ar(6).linlin(-1,1,2,4)).linexp(-1,1,800,12000).round(~fh * 2.6)}.dup(3), 0.002) * 0.005 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.00001), {LFDNoise0.ar(LFDNoise0.ar(6).linlin(-1,1,2,4)).linexp(-1,1,800,12000).round(~fh * 13)}.dup(3), 0.002) * 0.002 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.00001), {LFDNoise0.ar(LFDNoise0.ar(6).linlin(-1,1,2,4)).linexp(-1,1,800,12000).round(~fh * 13.3)}.dup(3), 0.002) * 0.002 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.00001), {LFDNoise0.ar(LFDNoise0.ar(6).linlin(-1,1,2,4)).linexp(-1,1,800,12000).round(~fh * 14)}.dup(3), 0.002) * 0.002 };

~out.play(b.index);
