fs = 32e3;
f1=7e3;
f2=9e3;
N=27
% design filter using Parks-McClellan method 
% note MATLAB specify N-1 for PM design
hh=firpm(N-1,[0 f1 f2 fs/2]/(fs/2), [1 1 0 0], [1 1]);

figure
[fr_hh, f]=freqz(hh,1, -pi:1/200:pi-1/200);

plot(f*(fs/(2*pi)./1000), 20*log10(abs(fr_hh)),'linewidth',1);
% convert to fixed point
hold on;grid on

hhf = round(hh*32768)

[fr_hhf, f]=freqz(hhf./32768,1, -pi:1/200:pi-1/200);
plot(f*(fs/(2*pi)./1000), 20*log10(abs(fr_hhf)),'linewidth',1);
xlim([-fs/2/1000 fs/2/1000])
ylim([-80 3])
