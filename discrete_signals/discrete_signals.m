clc; clear; close all;

figure;
% Range for the signals
n = -5:5;

% 1. Unit Impulse
impulse = (n == 0);
subplot(3,3,1);
stem(n, impulse, 'k');
xlabel('Samples n');
ylabel('Amplitude');
title('Unit Impulse');
grid on;

% 2. Unit Step Signal
unit_step = (n >= 0);
subplot(3,3,2);
stem(n, unit_step, 'k');
xlabel('Samples n');
ylabel('Amplitude');
title('Unit Step');
grid on;

% 3. Unit Ramp Signal
ramp_signal = max(0, n);
subplot(3,3,3);
stem(n, ramp_signal, 'k');
xlabel('Samples n');
ylabel('Amplitude');
title('Unit Ramp');
grid on;

% 4. Exponentially Decaying Signal
A = 1;
r = 0.2;
exp_d = A * exp(-r * n);
subplot(3,3,4);
stem(n, exp_d, 'k');
xlabel('Samples n');
ylabel('Amplitude');
title('Exponential Decay');
grid on;

% 5. Rectangular Signal
rectangular_signal = (n >= -2) & (n <= 2);
subplot(3,3,5);
stem(n, rectangular_signal, 'k');
xlabel('Samples n');
ylabel('Amplitude');
title('Rectangular');
grid on;

% 6. Triangular Signal
triangular_signal = 1 - abs(n)/max(abs(n));
triangular_signal(triangular_signal < 0) = 0;
subplot(3,3,6);
stem(n, triangular_signal, 'k');
xlabel('Samples n');
ylabel('Amplitude');
title('Triangular');
grid on;

% 7. Sinusoidal Signal
n = 0:15;
sinusoidal_signal = sin(n);
subplot(3,3,7);
stem(n, sinusoidal_signal, 'k');
xlabel('Samples n');
ylabel('Amplitude');
title('Sinusoidal');
grid on;

% 8. Sinc Signal
n = -10:10;
sinc_signal = sin(0.3 * pi * n) ./ (pi * n);
sinc_signal(n == 0) = 0.3;
subplot(3,3,8);
stem(n, sinc_signal, 'k');
xlabel('Samples n');
ylabel('Amplitude');
title('Sinc');
grid on;

% 9. Random Noise Signal
n = 1:100;
random_noise = rand(1, length(n));
subplot(3,3,9);
stem(n, random_noise, 'k');
xlabel('Samples n');
ylabel('Amplitude');
title('Random Noise');
grid on;

% Overall Title
sgtitle('Discrete Signal Sequence');

% Save the figure 
saveas(gcf, 'discrete_signals_plot.png');
