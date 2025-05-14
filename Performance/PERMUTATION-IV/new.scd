~mix.play(b.index);

~playbuf.ar(3);
~playbuf = { PlayBuf.ar(3, 0, 480/512 / 8 * LFPulse.ar(1/10.8/2).linlin(0,1,-1,1), startPos: 90000, trigger: Impulse.ar(1/10.8/2)) + (0 * WhiteNoise.ar) };
~playbuf = { PlayBuf.ar(3, 0, 480/512 / 8 * LFPulse.ar(1).linlin(0,1,-1,1), startPos: 90000, trigger: Impulse.ar(1/10.8/2)) + (0 * WhiteNoise.ar) };
~playbuf = { PlayBuf.ar(3, 0, 480/512 / 2 , startPos: 90000, loop: 1) + (0 * WhiteNoise.ar) };

~mix.ar(3);
~mix = {};
~mix = { ~playbuf.ar * 0.8 };
~mix = { BLowPass.ar(BHiPass.ar(~playbuf.ar, ~fh*[1/2], 0.01), LFDNoise3.ar(2).linexp(-1,1,800,12000).round(~fh * 3), [0.001, 0.1, 0.4]) * 0.002 };
~mix = { BLowPass.ar(BHiPass.ar(~playbuf.ar, ~fh*[1/2], 0.0001), {LFDNoise0.ar(LFDNoise0.ar(6).linlin(-1,1,2,4)).linexp(-1,1,800,12000).round(~fh * 12)}.dup(3), 0.002) * 0.003 };
~mix = { BLowPass.ar(BHiPass.ar(~playbuf.ar, ~fh*[1/2], 0.0001), LFDNoise3.ar(2).linexp(-1,1,800,12000).round(~fh * 3.5), [0.0001, 0.1, 0.4]) * 0.2 };
