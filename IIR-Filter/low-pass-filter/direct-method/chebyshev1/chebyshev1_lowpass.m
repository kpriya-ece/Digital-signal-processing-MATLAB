clc; clear; close all;

F1 = 1000; F2 = 2000; F3 = 3000;
Fsamp = 15000;
t = 0:1/Fsamp:0.01;
x = sin(2*pi*F1*t) + sin(2*pi*F2*t) + sin(2*pi*F3*t);

fft_ord = 1024;
x_fft = fft(x, fft_ord);

Fp = 2200; 
Fs = 2500; 
ap = 2.8; 
as = 45;
wp=2*Fp/Fsamp;
ws=2*Fs/Fsamp;
[N, wn] = buttord(wp,ws, ap, as);
[b, a] = butter(N, wn, "low");

n_range = 0:50; 
h = impz(b, a, length(n_range));

h_freq = freqz(b, a, fft_ord/2);

y = filter(b, a, x);
y_fft = fft(y, fft_ord);
fr = (1:fft_ord/2) * Fsamp / fft_ord;
figure;

[N1, wn1] = cheb1ord(wp, ws,ap, as);
[b1, a1] = cheby1(N1,ap,wp,"low");

h1 = impz(b1, a1, length(n_range));
h_freq1= freqz(b1, a1, fft_ord/2);
y1 = filter(b1, a1, x);
y_fft1 = fft(y1, fft_ord);

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
stem(n_range, h1, 'k'); 
title('Impulse Response');
ylabel('Amplitude');
xlabel('n');

subplot(3, 2, 4);
plot(fr, 20*log10(abs(h_freq1)), 'k'); 
title('Frequency Response');
ylabel('Magnitude (dB)');
xlabel('Frequency (Hz)');

subplot(3, 2, 5);
plot(t, y1, 'k');
title('Filtered Signal');
ylabel('Amplitude');
xlabel('Time (s)');

subplot(3, 2, 6);
plot(fr, abs(y_fft1(1:fft_ord/2)), 'k');
title('Filtered Signal Frequency Response');
ylabel('Magnitude');
xlabel('Frequency (Hz)');

sgtitle('CHEBYSHEV TYPE 1 LOW PASS FILTER (DIRECT METHOD)');
saveas(gcf, 'chebyshev1_lowpass.png');  % Save figure
