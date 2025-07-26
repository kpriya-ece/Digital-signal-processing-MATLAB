clc; clear;close all;
fs_signal = 1000; % Nyquist frequency
t = 0:1/fs_signal:0.6; 
f = 5; % frequency of original signal

signal = sin(2 * pi * f * t);

figure;

subplot(2, 2, 1);
plot(t, signal, 'k');
title('Continuous Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

fs_oversample = 100;  % Oversampling frequency (Hz)
fs_perfect = 10;     % Perfect sampling frequency (Hz)
fs_undersample = 4;  % Undersampling frequency (Hz)

% Oversampling
t_oversample = 0:1/fs_oversample:0.6;
signal_oversample = sin(2 * pi * f * t_oversample);
subplot(2, 2, 2);
stem(t_oversample, signal_oversample, 'k');
title('Oversampled Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Perfect sampling
t_perfect = 0:1/fs_perfect:0.6;
signal_perfect = sin(2 * pi * f * t_perfect);

subplot(2, 2, 3);
stem(t_perfect, round(signal_perfect), 'k');
title('Perfectly Sampled Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Undersampling
t_undersample = 0:1/fs_undersample:0.6;
signal_undersample = sin(2 * pi * f * t_undersample);

subplot(2, 2, 4);
stem(t_undersample, signal_undersample, 'k');
title('Undersampled Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

sgtitle('Verification of the Sampling Theorem');

saveas(gcf, 'sampling_theorem_plot.png');
