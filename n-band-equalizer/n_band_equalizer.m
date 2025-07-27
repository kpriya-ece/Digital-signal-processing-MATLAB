clc; clear all; close all;

fft_ord = 1024; % FFT order
Fsamp = 44000;  % Sampling frequency
t = 0:1/Fsamp:0.1;
fm = [200, 750, 1800, 2500, 4500, 6300, 10500];
x = zeros(1, length(t));

for i = 1:length(fm)
    x = x + sin(2*pi*fm(i)*t);
end

x_fft = abs(fft(x, fft_ord));
fr = (1:fft_ord/2) * Fsamp / fft_ord;

subplot(3, 4, 1), plot(fr, x_fft(1:fft_ord/2), 'k');
xlabel('Frequency'); ylabel('Magnitude'); title('Input Spectrum');

% Filter bands
fc1 = [100 1000];
fc2 = [1000 3000];
fc3 = [3000 8000];
fc4 = [8000 20000];

N = 101;  % FIR filter order

% Filter 1
h1 = fir1(N-1, 2*fc1/Fsamp, rectwin(N));
hr1 = freqz(h1, 1, fft_ord/2);
subplot(3, 4, 2), plot(fr, 20*log10(abs(hr1)), 'k'); title('Filter1 Spectrum');
y1 = filter(h1, 1, x);
y_fft1 = abs(fft(y1, fft_ord));
subplot(3, 4, 3), plot(fr, y_fft1(1:fft_ord/2), 'k'); title('Filter1 Output');

% Filter 2
h2 = fir1(N-1, 2*fc2/Fsamp, rectwin(N));
hr2 = freqz(h2, 1, fft_ord/2);
subplot(3, 4, 4), plot(fr, 20*log10(abs(hr2)), 'k'); title('Filter2 Spectrum');
y1 = filter(h2, 1, x);
y_fft1 = abs(fft(y1, fft_ord));
subplot(3, 4, 5), plot(fr, y_fft1(1:fft_ord/2), 'k'); title('Filter2 Output');

% Filter 3
h3 = fir1(N-1, 2*fc3/Fsamp, rectwin(N));
hr3 = freqz(h3, 1, fft_ord/2);
subplot(3, 4, 6), plot(fr, 20*log10(abs(hr3)), 'k'); title('Filter3 Spectrum');
y1 = filter(h3, 1, x);
y_fft1 = abs(fft(y1, fft_ord));
subplot(3, 4, 7), plot(fr, y_fft1(1:fft_ord/2), 'k'); title('Filter3 Output');

% Filter 4
h4 = fir1(N-1, 2*fc4/Fsamp, rectwin(N));
hr4 = freqz(h4, 1, fft_ord/2);
subplot(3, 4, 8), plot(fr, 20*log10(abs(hr4)), 'k'); title('Filter4 Spectrum');
y1 = filter(h4, 1, x);
y_fft1 = abs(fft(y1, fft_ord));
subplot(3, 4, 9), plot(fr, y_fft1(1:fft_ord/2), 'k'); title('Filter4 Output');

% Equalizer
gain1 = dfilt.scalar(1);
gain2 = dfilt.scalar(0.8);
gain3 = dfilt.scalar(0.5);
gain4 = dfilt.scalar(0.2);

F1 = dfilt.dffir(h1); H1 = dfilt.cascade(gain1, F1);
F2 = dfilt.dffir(h2); H2 = dfilt.cascade(gain2, F2);
F3 = dfilt.dffir(h3); H3 = dfilt.cascade(gain3, F3);
F4 = dfilt.dffir(h4); H4 = dfilt.cascade(gain4, F4);

Equalizer = dfilt.parallel(H1, H2, H3, H4);
[h, w] = freqz(Equalizer, fft_ord, Fsamp);

subplot(3, 4, 10);
plot(w, 20.*log10(abs(h)), 'k');
xlabel('Frequency (Hz)'); ylabel('Gain (dB)');
title('Equalizer Magnitude Response');

y_eq = filter(real(h), 1, x);
y_eq_fft1 = abs(fft(y_eq, fft_ord));
subplot(3, 4, 11), plot(fr, y_eq_fft1(1:fft_ord/2), 'k'); title('Equalizer Output');

y_eq1 = h' .* x_fft;
y_eq_fft2 = abs(ifft(y_eq1, fft_ord));
subplot(3, 4, 12), plot(fr, y_eq_fft2(1:fft_ord/2), 'k'); title('Equalizer Output');

% Save figure as PNG
saveas(gcf, 'equalizer_output_black.png');
