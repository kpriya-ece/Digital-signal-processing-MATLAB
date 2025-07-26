clc;
clear;
close all;
figure;

% Range of discrete-time signal 
n = -5:5; 
rectangular_signal = (n >= -2) & (n <= 2);  

% Time Shifting: Shifting by 2
shifted_rectangular = (n + 2 >= -2) & (n + 2 <= 2);  

% Amplitude Scaling: Scaling by 2
scaled_rectangular = 2 * rectangular_signal;  

% Time Scaling: Scaling by 1/2
scaled_time_rectangular = (n / 2 >= -2) & (n / 2 <= 2);  

% Amplitude Shifting: Shifting by 2
shifted_amplitude_rectangular = rectangular_signal + 2; 

subplot(3, 2, 1);
stem(n, rectangular_signal, 'k');
title('Rectangular Signal');
xlabel('Samples n');
ylabel('Amplitude');
grid on;

subplot(3, 2, 2);
stem(n, shifted_rectangular, 'k');
title('Time Shifting (Shifted by 2)');
xlabel('Samples n');
ylabel('Amplitude');
grid on;

subplot(3, 2, 3);
stem(n, scaled_rectangular, 'k');
title('Amplitude Scaling (Scaled by 2)');
xlabel('Samples n');
ylabel('Amplitude');
grid on;

subplot(3, 2, 4);
stem(n, scaled_time_rectangular, 'k');
title('Time Scaling (Scaled by 1/2)');
xlabel('Samples n');
ylabel('Amplitude');
grid on;

subplot(3, 2, 5);
stem(n, shifted_amplitude_rectangular, 'k');
title('Amplitude Shifting (Shifted by 2)');
xlabel('Samples n');
ylabel('Amplitude');
grid on;

sgtitle('Signal Operations');

% Save the figure 
saveas(gcf, 'discrete_signals_operation_plot.png');
