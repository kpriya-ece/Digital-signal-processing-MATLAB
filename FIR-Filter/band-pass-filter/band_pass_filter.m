clc; clear; close all;

fft_ord = 1024;
fs = 16000;
fc1 = 200;  
fc2 = 2000;  
wc1 = 2 * pi * fc1 / fs;  
wc2 = 2 * pi * fc2 / fs;

f1 = 500; f2 = 1000; f3 = 3000;
t = 0:1/fs:0.01;
x = sin(2*pi*f1*t) + sin(2*pi*f2*t) + sin(2*pi*f3*t);
fft_x = fft(x, fft_ord);

N = 121;
n_range = -(N-1)/2:(N-1)/2;


hd = zeros(1, N);
for n = n_range
   if n == 0
        hd(n + (N + 1) / 2) = (wc2 - wc1) / pi;  
    else
        hd(n + (N + 1) / 2) = (sin(wc2 * n) - sin(wc1 * n)) / (pi * n);
    end
end

% ---------------------- HAMMING WINDOW ----------------------
w = 0.54 + 0.46 * cos(2 * pi * n_range / (N - 1));
h = hd .* w;
y = filter(h, 1, x);
fft_y = fft(y, fft_ord);
h1 = freqz(h, 1, fft_ord / 2);
fr = (0:fft_ord-1) * fs / fft_ord;

figure;
subplot(3,2,1); plot(t, x, 'k'); title('Input Signal'); ylabel('Amplitude'); xlabel('Time (s)');
subplot(3,2,2); plot(fr(1:fft_ord/2), abs(fft_x(1:fft_ord/2)), 'k'); title('Input Signal Frequency Response'); ylabel('Magnitude'); xlabel('Frequency (Hz)');
subplot(3,2,3); stem(n_range, h, 'k'); title('Impulse Response'); ylabel('Amplitude'); xlabel('n');
subplot(3,2,4); plot(fr(1:fft_ord/2), 20*log10(abs(h1)), 'k'); title('Frequency Response'); ylabel('Magnitude (dB)'); xlabel('Frequency (Hz)');
subplot(3,2,5); plot(t, y, 'k'); title('Filtered Signal'); ylabel('Amplitude'); xlabel('Time (s)');
subplot(3,2,6); plot(fr(1:fft_ord/2), abs(fft_y(1:fft_ord/2)), 'k'); title('Filtered Signal Frequency Response'); ylabel('Magnitude'); xlabel('Frequency (Hz)');
sgtitle('BAND PASS FILTER (HAMMING)');
saveas(gcf, 'band_pass_hamming.png');

%---------------------- RECTANGULAR WINDOW ----------------------
wr = ones(1, N);
h = hd .* wr;
y = filter(h, 1, x);
fft_ord = 1000;
fft_x = fft(x, fft_ord);
fft_y = fft(y, fft_ord);
h2 = freqz(h, 1, fft_ord / 2);
fr = (0:fft_ord-1) * (fs / fft_ord);

figure;
subplot(3,2,1); plot(t, x, 'k'); title('Input Signal'); ylabel('Amplitude'); xlabel('Time (s)');
subplot(3,2,2); plot(fr(1:fft_ord/2), abs(fft_x(1:fft_ord/2)), 'k'); title('Input Signal Frequency Response'); ylabel('Magnitude'); xlabel('Frequency (Hz)');
subplot(3,2,3); stem(n_range, h, 'k'); title('Impulse Response'); ylabel('Amplitude'); xlabel('n');
subplot(3,2,4); plot(fr(1:fft_ord/2), 20*log10(abs(h2)), 'k'); title('Frequency Response'); ylabel('Magnitude (dB)'); xlabel('Frequency (Hz)');
subplot(3,2,5); plot(t, y, 'k'); title('Filtered Signal'); ylabel('Amplitude'); xlabel('Time (s)');
subplot(3,2,6); plot(fr(1:fft_ord/2), abs(fft_y(1:fft_ord/2)), 'k'); title('Filtered Signal Frequency Response'); ylabel('Magnitude'); xlabel('Frequency (Hz)');
sgtitle('BAND PASS FILTER (RECTANGULAR)');
saveas(gcf, 'band_pass_rectangular.png');

% ---------------------- HANNING WINDOW ----------------------
wh = 0.5 + 0.5 * cos(2 * pi * n_range / (N - 1));
h = hd .* wh;
y = filter(h, 1, x);
fft_ord = 1000;
fft_x = fft(x, fft_ord);
fft_y = fft(y, fft_ord);
h3 = freqz(h, 1, fft_ord / 2);
fr = (0:fft_ord-1) * (fs / fft_ord);

figure;
subplot(3,2,1); plot(t, x, 'k'); title('Input Signal'); ylabel('Amplitude'); xlabel('Time (s)');
subplot(3,2,2); plot(fr(1:fft_ord/2), abs(fft_x(1:fft_ord/2)), 'k'); title('Input Signal Frequency Response'); ylabel('Magnitude'); xlabel('Frequency (Hz)');
subplot(3,2,3); stem(n_range, h, 'k'); title('Impulse Response'); ylabel('Amplitude'); xlabel('n');
subplot(3,2,4); plot(fr(1:fft_ord/2), 20*log10(abs(h3)), 'k'); title('Frequency Response'); ylabel('Magnitude (dB)'); xlabel('Frequency (Hz)');
subplot(3,2,5); plot(t, y, 'k'); title('Filtered Signal'); ylabel('Amplitude'); xlabel('Time (s)');
subplot(3,2,6); plot(fr(1:fft_ord/2), abs(fft_y(1:fft_ord/2)), 'k'); title('Filtered Signal Frequency Response'); ylabel('Magnitude'); xlabel('Frequency (Hz)');
sgtitle('BAND PASS FILTER (HANNING)');
saveas(gcf, 'band_pass_hanning.png');
