// AUDIO
p.fadeTime = 0;
p.fadeTime = 3;
p.fadeTime = 5;
p.fadeTime = 10;
p.fadeTime = 20;
p.fadeTime = 30;

~mix = { ~pan.ar };

~pan = { PanAz.ar(3, ~sig.ar, ~panner.ar + [-1/3, 1/3, 1], 1, 2.0, 0.5).sum };
// ~pan = { PanX.ar(3, ~sig.ar, ~panner.ar + [0, 0.5, 1], 1, 1.0).sum };

~panner = { 0.0 };
~panner = { SinOsc.ar(1/30).linlin(-1,1,0,2) };
~panner = { SinOsc.ar(1/15).linlin(-1,1,0,2) };
~panner = { SinOsc.ar(1/5).linlin(-1,1,0,2) };
~panner = { SinOsc.ar(1/3).linlin(-1,1,0,2) };
~panner = { SinOsc.ar(1/2).linlin(-1,1,0,2) };
~panner = { SinOsc.ar(1).linlin(-1,1,0,2) };
~panner = { SinOsc.ar(2 * 1).linlin(-1,1,0,2) };
~panner = { SinOsc.ar(200 * (2**0)).linlin(-1,1,0,2) };

~sig = {  };
~sig = { (SinOsc.ar(~fh) ! 3).flat };
~sig = { SelectXFocus(LFDNoise3.ar(1/6).linlin(-1,1,0,2), [SinOsc.ar(~fh), LFTri.ar(~fh), LFPulse.ar(~fh)]) ! 3 };
~sig = { SelectXFocus(LFDNoise3.ar(1/2).linlin(-1,1,0,2), [SinOsc.ar(~fh), LFTri.ar(~fh), LFPulse.ar(~fh)]) ! 3 };
~sig = { SelectXFocus(LFDNoise3.ar(1).linlin(-1,1,0,2), [SinOsc.ar(~fh), LFTri.ar(~fh), LFPulse.ar(~fh)]) ! 3 };
~sig = { SelectXFocus(LFDNoise3.ar(2).linlin(-1,1,0,2), [SinOsc.ar(~fh * [1, 3.7, 1.5, 2, 3.46, 8.31].scramble / [1, 2, 3.4]), LFTri.ar(~fh), LFPulse.ar(~fh)]) ! 3 };
~sig = { SelectXFocus(LFDNoise3.ar(1).linlin(-1,1,0,2), [SinOsc.ar(~fh * [1, 3, 1.5, 2.7, 3.1] / 4), LFTri.ar(~fh), LFPulse.ar(~fh)]) ! 3 };
//UNTEN: Modulieren anstatt das es über die Zeit hinweg driftet
~sig = { SelectXFocus(LFDNoise3.ar(2).linlin(-1,1,0,2), [SinOsc.ar(~fh * [1, 3.5, 1.3, 6.7].scramble / [1, 2, 4]), LFTri.ar(~fh * { 1.0.rand.linlin(0,1,0.999,1) }.dup(3)), LFPulse.ar(~fh * { 1.0.rand.linlin(0,1,0.9999,1) }.dup(6))]) };
~sig = { SelectXFocus(LFDNoise3.ar(2).linlin(-1,1,0,2), [SinOsc.ar((~fh * [1, 2].scramble) + {0.001.rand}.dup(6)), LFTri.ar(~fh * { 1.0.rand.linlin(0,1,0.99,1) }.dup(3)), LFPulse.ar(~fh * { 1.0.rand.linlin(0,1,0.99,1) }.dup(3))]) };
~sig = { SelectXFocus(LFDNoise3.ar(2).linlin(-1,1,0,2), [SinOsc.ar((~fh * [1, 2, 2.67, 1.51, 7.35].scramble) + {0.001.rand}.dup(6)), LFTri.ar(~fh * { 1.0.rand.linlin(0,1,0.999,1) }.dup(3)), LFPulse.ar(~fh * { 1.0.rand.linlin(0,1,0.999,1) }.dup(3))]) };
~sig = { SelectXFocus(LFDNoise3.ar(2).linlin(-1,1,0,2), [SinOsc.ar((~fh * [1, 1.6, 2.7, 3.37].scramble) + {0.001.rand}.dup(6)), LFTri.ar(~fh * { 1.0.rand.linlin(0,1,0.999,1) }.dup(3)), LFPulse.ar(~fh * { 1.0.rand.linlin(0,1,0.999,1) }.dup(3))]) };
~sig = { SelectXFocus(LFDNoise3.ar(4).linlin(-1,1,0,2), [SinOsc.ar((~fh * [1, 2, 3, 4, 6, 1.5, 2.37, 4.52].scramble) + {0.001.rand}.dup(6)), LFTri.ar(~fh * { 1.0.rand.linlin(0,1,0.99,1) }.dup(3)), LFPulse.ar(~fh * { 1.0.rand.linlin(0,1,0.99,1) }.dup(3))]) };

// ~sig = { (LFGauss.ar((1/(~fh * [1, 2]))) * 0.1).tanh };
// ~sig = { LFGauss.ar((1/(~fh * [1, 2])) + {0.001.rand}.dup(6)).tanh };
~sig = { LeakDC.ar(LFGauss.ar(1/~fh, LFDNoise3.kr(1/6).linlin(-1,1,0.05,1.0), {LFDNoise3.ar(1/10).linlin(-1,1,0,0.1)}.dup(6))) }
~sig = { LeakDC.ar(LFGauss.ar(1/(~fh * [1, 2, 1.89].scramble), LFDNoise3.kr(1/6).linlin(-1,1,0.05,1.0), {LFDNoise3.ar(1/10).linlin(-1,1,0,0.1)}.dup(3))) }
~sig = { LeakDC.ar(LFGauss.ar(1/(~fh * [1, 2, 3.5, 2.37, 2.6, 6.8, 1.3].scramble), LFDNoise3.kr(1/6).linlin(-1,1,0.05,1.0), {LFDNoise3.ar(1/10).linlin(-1,1,0,0.1)}.dup(3))) }
~sig = { LeakDC.ar(LFGauss.ar(1/(~fh * [1, 2, 3.5, 2.37].scramble), LFDNoise3.kr(1/6).linlin(-1,1,0.05,1.0), {LFDNoise3.ar(1/10).linlin(-1,1,0,0.1)}.dup(6))) }
~sig = { LeakDC.ar(LFGauss.ar((1/(~fh * [1, 2, 1.5, 3.5, 1/2, 4.5, 7])), LFDNoise3.kr(1/6).linlin(-1,1,0.05,1.0), {LFDNoise3.ar(1/10).linlin(-1,1,0,0.1)}.dup(3))) }
~sig = { LeakDC.ar(LFGauss.ar(1/(~fh * ([1, 2, 1.5, 3.5, 1/2, 4.5, 7] * {1.0.rand.linlin(0,1,0.9,1.1)}.dup(32))), LFDNoise3.kr(1/6).linlin(-1,1,0.1,1.0), {LFDNoise3.ar(1/10).linlin(-1,1,0,0.01)}.dup(6))) }
~sig = { LeakDC.ar(LFGauss.ar((1/(~fh * [1, 2])) + {0.001.rand}.dup(16), LFDNoise3.kr(1/6).linlin(-1,1,0.05,1.0), {LFDNoise3.ar(1/10).linlin(-1,1,0,0.1)}.dup(3))) }
~sig = { LeakDC.ar(LFGauss.ar((1/(~fh * [1, 2, 2.5, 8, 6] / [1, 2, 4].scramble)) + {0.001.rand}.dup(32), LFDNoise3.kr(1/6).linlin(-1,1,0.05,1.0), {LFDNoise3.ar(1/10).linlin(-1,1,0,0.1)}.dup(6))) }
~sig = { LeakDC.ar(LFGauss.ar((1/(~fh * [1, 2, 2.5, 8, 6] / [1, 2, 4, 0.5].scramble)) + {0.1.rand}.dup(12), LFDNoise3.kr(1/6).linlin(-1,1,0.05,1.0), {LFDNoise3.ar(1/10).linlin(-1,1,0,0.001)}.dup(3))) }
~sig = { LeakDC.ar(LFGauss.ar((1/(~fh * [1, 2, 2.5, 8, 6] / [1, 2, 4].scramble)) * {1.rand.linlin(0,1,0.8,1.2)}.dup(6), LFDNoise3.kr(1/6).linlin(-1,1,0.05,1.0), {LFDNoise3.ar(1/10).linlin(-1,1,0,0.001)}.dup(3))) }

~pitch = { LeakDC.ar(LFGauss.ar(1/(~fh * (2 ** 2) / 1), LFDNoise1.ar(300).linlin(-1,1,0.001,1.0), {LFDNoise3.ar(1/2).linlin(-1,1,0,0.2)}.dup(3))).tanh }

~mix.play(b.index);
~pitch.play(~pitch_bus.index);
