clc; clear; close all;

fft_ord = 1024;
Fc = 2000;
Fsamp = 16000;
f1 = 500;
f2 = 1000;
f3 = 3000;
t = 0:1/Fsamp:0.01;
x = sin(2*pi*f1*t) + sin(2*pi*f2*t) + sin(2*pi*f3*t);

% FFT of input
fft_x = fft(x, fft_ord);

% Ideal LPF
N = 121;
wc = 2*pi*Fc/Fsamp;
hd = zeros(1, N);
for n = -(N-1)/2:(N-1)/2
    if n == 0
        hd(n + (N + 1) / 2) = wc / pi;
    else
        hd(n + (N + 1) / 2) = sin(wc * n) / (pi * n);
    end
end
n_range = -(N-1)/2:(N-1)/2;
fr = (1:fft_ord) * Fsamp / fft_ord;

% 1. Hamming Window
w = 0.54 + 0.46 * cos(2 * pi * n_range / (N - 1));
h = hd .* w;
h1 = freqz(h, 1, fft_ord / 2);
y = filter(h, 1, x);
fft_y = fft(y, fft_ord);

figure;
subplot(3,2,1); plot(t, x, 'k'); title('Input Signal');
subplot(3,2,2); plot(fr(1:fft_ord/2), abs(fft_x(1:fft_ord/2)), 'k'); title('Input Spectrum');
subplot(3,2,3); stem(n_range, h, 'k'); title('Impulse Response');
subplot(3,2,4); plot(fr(1:fft_ord/2), 20*log10(abs(h1)), 'k'); title('Filter Response (dB)');
subplot(3,2,5); plot(t, y, 'k'); title('Filtered Signal');
subplot(3,2,6); plot(fr(1:fft_ord/2), abs(fft_y(1:fft_ord/2)), 'k'); title('Filtered Spectrum');
sgtitle('LOW PASS FILTER (HAMMING)');
saveas(gcf, 'lowpass_hamming.png');

% 2. Rectangular Window
wr = ones(1, N);
h = hd .* wr;
y = filter(h, 1, x);
fft_y = fft(y, fft_ord);
h2 = freqz(h, 1, fft_ord / 2);

figure;
subplot(3,2,1); plot(t, x, 'k'); title('Input Signal');
subplot(3,2,2); plot(fr(1:fft_ord/2), abs(fft_x(1:fft_ord/2)), 'k'); title('Input Spectrum');
subplot(3,2,3); stem(n_range, h, 'k'); title('Impulse Response');
subplot(3,2,4); plot(fr(1:fft_ord/2), 20*log10(abs(h2)), 'k'); title('Filter Response (dB)');
subplot(3,2,5); plot(t, y, 'k'); title('Filtered Signal');
subplot(3,2,6); plot(fr(1:fft_ord/2), abs(fft_y(1:fft_ord/2)), 'k'); title('Filtered Spectrum');
sgtitle('LOW PASS FILTER (RECTANGULAR)');
saveas(gcf, 'lowpass_rectangular.png');

%3. Hanning Window
wh = 0.5 + 0.5 * cos(2 * pi * n_range / (N - 1));
h = hd .* wh;
y = filter(h, 1, x);
fft_y = fft(y, fft_ord);
h3 = freqz(h, 1, fft_ord / 2);

figure;
subplot(3,2,1); plot(t, x, 'k'); title('Input Signal');
subplot(3,2,2); plot(fr(1:fft_ord/2), abs(fft_x(1:fft_ord/2)), 'k'); title('Input Spectrum');
subplot(3,2,3); stem(n_range, h, 'k'); title('Impulse Response');
subplot(3,2,4); plot(fr(1:fft_ord/2), 20*log10(abs(h3)), 'k'); title('Filter Response (dB)');
subplot(3,2,5); plot(t, y, 'k'); title('Filtered Signal');
subplot(3,2,6); plot(fr(1:fft_ord/2), abs(fft_y(1:fft_ord/2)), 'k'); title('Filtered Spectrum');
sgtitle('LOW PASS FILTER (HANNING)');
saveas(gcf, 'lowpass_hanning.png');
