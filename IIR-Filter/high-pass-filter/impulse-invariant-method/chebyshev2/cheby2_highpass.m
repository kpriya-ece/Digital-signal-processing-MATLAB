clc; clear; close all;

% Signal Generation
F1 = 1000; F2 = 2000; F3 = 3000;
Fsamp = 15000;
t = 0:1/Fsamp:0.01;
x = sin(2*pi*F1*t) + sin(2*pi*F2*t) + sin(2*pi*F3*t);

fft_ord = 1024;
x_fft = fft(x, fft_ord);
fr = (1:fft_ord/2) * Fsamp / fft_ord;

Fp = 2800; 
Fs = 2200; 
ap = 2.5; 
as = 45;
wp = 2 * pi * Fp;
ws = 2 * pi * Fs;

n_range = 0:50;

% Chebyshev Type II High Pass 
[N2, wn2] = cheb2ord(wp, ws, ap, as, "s");
[bs3, as3] = cheby2(N2, as, wn2, "high", "s");
[bz3, az3] = impinvar(bs3, as3, Fsamp);

h2 = impz(bz3, az3, length(n_range));
h_freq2 = freqz(bz3, az3, fft_ord/2);
y2 = filter(bz3, az3, x);
y_fft2 = fft(y2, fft_ord);

figure;
subplot(3,2,1); plot(t, x, 'k'); title('Input Signal'); xlabel('Time (s)'); ylabel('Amplitude');
subplot(3,2,2); plot(fr, abs(x_fft(1:fft_ord/2)), 'k'); title('Input Signal Frequency Response'); xlabel('Frequency (Hz)'); ylabel('Magnitude');
subplot(3,2,3); stem(n_range, h2, 'k'); title('Impulse Response'); xlabel('n'); ylabel('Amplitude');
subplot(3,2,4); plot(fr, 20*log10(abs(h_freq2)), 'k'); title('Frequency Response'); xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)');
subplot(3,2,5); plot(t, y2, 'k'); title('Filtered Signal'); xlabel('Time (s)'); ylabel('Amplitude');
subplot(3,2,6); plot(fr, abs(y_fft2(1:fft_ord/2)), 'k'); title('Filtered Signal Frequency Response'); xlabel('Frequency (Hz)'); ylabel('Magnitude');
sgtitle('CHEBYSHEV TYPE 2 HIGH PASS FILTER (IMPULSE INVARIANT METHOD)');
saveas(gcf, 'cheby2_highpass.png');
