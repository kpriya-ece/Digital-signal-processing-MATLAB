clc; clear; close all;

F1 = 1000; F2 = 2000; F3 = 3000;
Fsamp = 15000;
t = 0:1/Fsamp:0.01;
x = sin(2*pi*F1*t) + sin(2*pi*F2*t) + sin(2*pi*F3*t);

fft_ord = 1024;
x_fft = fft(x, fft_ord);

Fp = 2500; Fs = 2200; ap = 2.8; as = 45;
wp=2*Fsamp*tan(pi*Fp/Fsamp);
ws=2*Fsamp*tan(pi*Fs/Fsamp);

[N, wn] = buttord(wp, ws, ap, as,"s");
[bs1,as1] = butter(N,wn,"high","s");
[bz1,az1] = bilinear(bs1,as1,Fsamp);

n_range = 0:50; 
h = impz(bz1,az1, length(n_range));

h_freq=freqz(bz1,az1,fft_ord/2);
y = filter(bz1,az1, x);
y_fft=fft(y,fft_ord);

fr = (1:fft_ord/2) * Fsamp / fft_ord;


figure;

[N2, wn2] = cheb2ord(wp, ws, ap, as,"s");
[bs2,as2] = cheby2(N2,as,wn2,"high","s");
[bz2,az2] = bilinear(bs2,as2,Fsamp);

h2 = impz(bz2,az2, length(n_range));

h_freq2=freqz(bz2,az2,fft_ord/2);
y2 = filter(bz2,az2, x);
y_fft2=fft(y2,fft_ord);  
subplot(3, 2, 1);
plot(t, x, 'k');
title('Input Signal');
ylabel('Amplitude');
xlabel('Time (s)');

subplot(3, 2, 2);
plot(fr, abs(x_fft(1:fft_ord/2)), 'k');
title('Input Signal Frequency Response');
ylabel('Magnitude');
xlabel('Frequency (Hz)');

subplot(3, 2, 3);
stem(n_range, h2, 'k'); 
title('Impulse Response');
ylabel('Amplitude');
xlabel('n');

subplot(3, 2, 4);
plot(fr, 20*log10(abs(h_freq2)), 'k'); 
title('Frequency Response');
ylabel('Magnitude (dB)');
xlabel('Frequency (Hz)');

subplot(3, 2, 5);
plot(t, y2, 'k');
title('Filtered Signal');
ylabel('Amplitude');
xlabel('Time (s)');

subplot(3, 2, 6);
plot(fr, abs(y_fft2(1:fft_ord/2)), 'k');
title('Filtered Signal Frequency Response');
ylabel('Magnitude');
xlabel('Frequency (Hz)');

sgtitle('CHEBYSHEV TYPE 2 HIGH PASS FILTER (BILINEAR METHOD)');
saveas(gcf, 'chebyshev2_highpass.png');
