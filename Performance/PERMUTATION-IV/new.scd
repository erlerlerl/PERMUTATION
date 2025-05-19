~sig.fadeTime = 30;
~sig.fadeTime = 0;

~sig = {};
~sig = { Pulse.ar(60 / ~fh, width: [0.5, 0.25, 0.125]) }

~sig = { PlayBuf.ar(3, 0, 480/512 / 60, startPos: 90000, loop: 1, trigger: Impulse.ar(1/60)) };  // GREG, start with GREG please
~sig = { PlayBuf.ar(3, 0, 480/512 / 45, startPos: 90000, loop: 1, trigger: Impulse.ar(1/60)) };
~sig = { PlayBuf.ar(3, 0, 480/512 / 35, startPos: 90000, loop: 1, trigger: Impulse.ar(1/60)) };
~sig = { PlayBuf.ar(3, 0, 480/512 / 25, startPos: 90000, loop: 1, trigger: Impulse.ar(1/60)) };
~sig = { PlayBuf.ar(3, 0, 480/512 / 15, startPos: 90000, loop: 1, trigger: Impulse.ar(1/15)) };
~sig = { PlayBuf.ar(3, 0, 480/512 / 8 * LFPulse.ar(1/10.8/2).linlin(0,1,-1,1), startPos: 90000, trigger: Impulse.ar(1/10.8/2)) + (0 * WhiteNoise.ar) };
~sig = { PlayBuf.ar(3, 0, 480/512 / 8 * LFPulse.ar(1/10.8/2).linlin(0,1,-1,1), startPos: 90000, trigger: Impulse.ar(1/10.8/2)) + (0 * WhiteNoise.ar) };
~sig = { PlayBuf.ar(3, 0, 480/512 / 6 * LFPulse.ar(1/10.8/2).linlin(0,1,-1,1), startPos: 90000, trigger: Impulse.ar(1/10.8/2)) + (0 * WhiteNoise.ar) };
~sig = { PlayBuf.ar(3, 0, 480/512 / 4 * LFPulse.ar(1/10.8/2).linlin(0,1,-1,1), startPos: 90000, trigger: Impulse.ar(1/10.8)) + (0 * WhiteNoise.ar) };
~sig = { PlayBuf.ar(3, 0, 480/512 / 2 , startPos: 90000, loop: 1) + (0 * WhiteNoise.ar) };
~sig = { PlayBuf.ar(3, 0, 480/512, loop: 1) } // PEG, just with the end please

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

~out = { BHiPass.ar(~sig.ar, LFDNoise3.ar(2).linexp(-1,1,20,200), [0.4, 0.2, 0.5]).tanh };
~out = { BHiPass.ar(~sig.ar, LFDNoise3.ar(LFDNoise1.ar(1/2).range(1/4, 3)).linexp(-1,1,20,200), [0.4, 0.2, 0.5]).tanh };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, LFDNoise3.ar(LFDNoise1.ar(1/2).range(1/4, 3)).linexp(-1,1,20,200), [0.4, 0.2, 0.5]).tanh, LFDNoise3.ar(LFDNoise1.ar(1/2).range(1/4, 3)).linexp(-1,1,800,2000), [0.1, 0.2, 0.6]).tanh.tanh };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, LFDNoise3.ar(LFDNoise1.ar(1/2).range(1/4, 3)).linexp(-1,1,20,200), [0.4, 0.2, 0.5]).tanh, LFDNoise3.ar(LFDNoise1.ar(1/2).range(1/4, 3)).linexp(-1,1,800,2000), [0.08, 0.1, 0.3]).tanh.tanh };

~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.4), LFDNoise3.ar(2).linexp(-1,1,800,12000), 0.4) * 0.2 };

~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.1), LFDNoise3.ar(2).linexp(-1,1,800,12000), [0.001, 0.1, 0.4]) * 0.2 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.08), LFDNoise3.ar(2).linexp(-1,1,800,12000), [0.001, 0.1, 0.4]) * 0.2 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.04), LFDNoise3.ar(2).linexp(-1,1,800,12000), [0.001, 0.1, 0.4]) * 0.2 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.03), LFDNoise3.ar(2).linexp(-1,1,800,12000), [0.001, 0.1, 0.4]).tanh * 0.2 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.03), LFDNoise3.ar(2).linexp(-1,1,700,12000), [0.001, 0.1, 0.4]).tanh * 0.4 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.02), LFDNoise3.ar(2).linexp(-1,1,800,12000), [0.001, 0.1, 0.4]).tanh * 0.2 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.015), LFDNoise3.ar(2).linexp(-1,1,800,12000), [0.001, 0.1, 0.4]).tanh * 0.4 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.001), LFDNoise3.ar(2).linexp(-1,1,800,12000), [0.001, 0.1, 0.4]).tanh.tanh * 0.9 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.001), LFDNoise3.ar(2).linexp(-1,1,800,12000).wrap(800,900), [0.001, 0.1, 0.4]).tanh.tanh * 0.9 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.001), LFDNoise3.ar(2).linexp(-1,1,800,12000).wrap(800,820), [0.0005, 0.1, 0.4]).tanh.tanh * 0.9 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.001), LFDNoise3.ar(2).linexp(-1,1,800,12000).wrap(800,900), [0.0005, 0.1, 0.4]).tanh.tanh * 0.9 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.001), LFDNoise3.ar(2).linexp(-1,1,800,12000).wrap(900,1000), [0.0005, 0.1, 0.4]).tanh.tanh * 0.9 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.001), LFDNoise3.ar(2).linexp(-1,1,800,12000).wrap(900,1080), [0.0005, 0.1, 0.4]).tanh.tanh * 0.9 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.001), LFDNoise3.ar(2).linexp(-1,1,800,12000).wrap(1000,1080).round(~fh), [0.0005, 0.1, 0.4]).tanh.tanh * 0.9 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.001), LFDNoise3.ar(2).linexp(-1,1,800,12000).wrap(1100,1280).round(~fh), [0.0005, 0.1, 0.4]).tanh.tanh * 0.9 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.001), LFDNoise3.ar(2).linexp(-1,1,800,12000).wrap(1100,1280).round(~fh), [0.0005, 0.1, 0.4]).tanh.tanh * 0.9 };

~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.01), LFDNoise3.ar(2).linexp(-1,1,800,12000).round(~fh * 3), [0.001, 0.1, 0.4]).tanh * 0.8 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.0001), {LFDNoise0.ar(LFDNoise0.ar(6).linlin(-1,1,2,4)).linexp(-1,1,800,12000).round(~fh * 12)}.dup(3), 0.002) * 0.3 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.0001), LFDNoise3.ar(2).linexp(-1,1,800,12000).round(~fh * 3.5), [0.0001, 0.1, 0.4]).tanh * 0.3 };
~out = { SelectX.ar(LFTri.ar(~fh/8).range(0,1), [BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.0001), LFDNoise3.ar(2).linexp(-1,1,800,12000).wrap(600,1200).round(~fh * 3.5), [0.0001, 0.1, 0.4]).tanh * 0.3, ~sig.ar.linlin(0,1,-1,1)]) };

// AMBIENT
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.01), LFDNoise3.ar(2).linexp(-1,1,800,12000).round(~fh * 3), [0.001, 0.1, 0.4]) * 0.002 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.0001), {LFDNoise0.ar(LFDNoise0.ar(6).linlin(-1,1,2,4)).linexp(-1,1,800,12000).round(~fh * 12)}.dup(3), 0.002) * 0.003 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.00004), {LFDNoise0.ar(LFDNoise0.ar(6).linlin(-1,1,2,4)).linexp(-1,1,800,12000).round(~fh * 2.6)}.dup(3), 0.002) * 0.005 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.00001), {LFDNoise0.ar(LFDNoise0.ar(6).linlin(-1,1,2,4)).linexp(-1,1,800,12000).round(~fh * 13)}.dup(3), 0.002) * 0.002 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.00001), {LFDNoise0.ar(LFDNoise0.ar(6).linlin(-1,1,2,4)).linexp(-1,1,800,12000).round(~fh * 13.3)}.dup(3), 0.002) * 0.002 };
~out = { BLowPass.ar(BHiPass.ar(~sig.ar, ~fh*[1/2], 0.00001), {LFDNoise0.ar(LFDNoise0.ar(6).linlin(-1,1,2,4)).linexp(-1,1,800,12000).round(~fh * 14)}.dup(3), 0.002) * 0.002 };


~out.play;
~out.play(b.index);
