(
Ndef(\fede, {
  Splay.ar({BPF.ar(LFGauss.ar(1/(40 + Ndef.ar(\fede).linlin(-1,1,70,LFNoise2.kr(1/4).linlin(-1,1,200,400))), 0.3), {LFNoise0.kr(1).linlin(-1,1,200,800)}!3, 0.01)}!3);
}).play
)

(
Ndef(\defe, {
  ({Ringz.ar(Blip.ar(LFNoise0.kr(1/4).linlin(-1,1,1/2,2).round(1/2).lag(0.2), 900), Ndef.ar(\defe).linlin(-1,1,40,50), 0.1)}!2 * 0.01).tanh;
}).play
)

