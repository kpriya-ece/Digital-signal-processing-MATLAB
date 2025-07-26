% 3.a DFT of sequence
x = [1, 2, 3, 4]; 
N1 = length(x);
X1 = zeros(1, N1);
for k = 0:N1-1
    for n = 0:N1-1
        X1(k+1) = X1(k+1) + x(n+1) * exp(-1i * 2 * pi * k * n / N1);
    end
end

fig1 = figure;
subplot(3, 1, 1);
stem(abs(x), 'k');
title('3.a.Input sequence');
xlabel('Samples n');
ylabel('Amplitude');
grid on;

subplot(3, 1, 2);
stem(abs(X1), 'k');
title('Magnitude of DFT sequence');
xlabel('Frequency index');
ylabel('Amplitude');
grid on;

subplot(3, 1, 3);
stem(angle(X1), 'k');
title('Phase angle of DFT sequence');
xlabel('Frequency index');
ylabel('Amplitude');
grid on;
saveas(fig1, '3a_input_dft.png');

% 3.b.1 DFT of sin signal
A1 = 2;
f = 1000;
fs = 15000;
t1 = 0:1/fs:2/f; 
signal = A1*sin(2 * pi * f * t1);
N2 = length(signal);
X2 = zeros(1, N2);
f_vals1 = (fs * (0:N2-1)) / N2;

for k = 0:N2-1
    for n = 0:N2-1
        X2(k+1) = X2(k+1) + signal(n+1) * exp(-1i * 2 * pi * k * n / N2);
    end
end

fig2 = figure;
subplot(3, 1, 1);
stem(t1, abs(signal), 'k');
title('3.b.1.Sin Signal');
xlabel('Time(s)');
ylabel('Amplitude');
grid on;

subplot(3, 1, 2);
stem(f_vals1, abs(X2), 'k');
title('Magnitude of DFT of Sin Signal');
xlabel('Frequency');
ylabel('Amplitude');
grid on;

subplot(3, 1, 3);
stem(f_vals1, angle(X2), 'k');
title('Phase angle of DFT sequence');
xlabel('Frequency');
ylabel('Amplitude');
grid on;
saveas(fig2, '3b1_sin_dft.png');

% 3.b.2 Sin with zero padding
A2 = 2;
fs = 50000;
t2 = 0:1/fs:1/f; 
signal = A2*sin(2 * pi * f * t2);
N3 = 6000;
signal = [signal, zeros(1, N3 - length(signal))];
X3 = zeros(1, N3);
f_vals2 = (fs * (0:N3-1)) / N3;
t2 = 0:1/fs:(N3-1)/fs;

for k = 0:N3-1
    for n = 0:N3-1
        X3(k+1) = X3(k+1) + signal(n+1) * exp(-1i * 2 * pi * k * n / N3);
    end
end

fig3 = figure;
subplot(3, 1, 1);
stem(t2, abs(signal), 'k', 'LineWidth', 0.1);
title('3.b.2.Sin Signal with Zero Padding');
xlabel('Time(s)');
ylabel('Amplitude');
grid on;

subplot(3, 1, 2);
stem(f_vals2, abs(X3), 'k', 'LineWidth', 0.1);
title('Magnitude of DFT with Zero Padding');
xlabel('Frequency');
ylabel('Amplitude');
grid on;

subplot(3, 1, 3);
stem(f_vals2, angle(X3), 'k', 'LineWidth', 0.1);
title('Phase angle of DFT with Zero Padding');
xlabel('Frequency');
ylabel('Amplitude');
grid on;
saveas(fig3, '3b2_sin_zero_padding_dft.png');

% 3.b.3 Sin without zero padding, more cycles
A3 = 2;
t3 = 0:1/fs:10/f; 
signal = A3*sin(2 * pi * f * t3);
N4 = length(signal);
X4 = zeros(1, N4);
f_vals3 = (fs * (0:N4-1)) / N4;

for k = 0:N4-1
    for n = 0:N4-1
        X4(k+1) = X4(k+1) + signal(n+1) * exp(-1i * 2 * pi * k * n / N4);
    end
end

fig4 = figure;
subplot(3, 1, 1);
stem(t3, abs(signal), 'k', 'LineWidth', 0.1);
title('3.b.3.Sin Signal with More Frequency Cycles');
xlabel('Time(s)');
ylabel('Amplitude');
grid on;

subplot(3, 1, 2);
stem(f_vals3, abs(X4), 'k', 'LineWidth', 1);
title('Magnitude of DFT with More Frequency Cycles');
xlabel('Frequency');
ylabel('Amplitude');
grid on;

subplot(3, 1, 3);
stem(f_vals3, angle(X4), 'k', 'LineWidth', 0.1);
title('Phase angle of DFT with More Frequency Cycles');
xlabel('Frequency');
ylabel('Amplitude');
grid on;
saveas(fig4, '3b3_sin_more_cycles_dft.png');

% 3.c.1 multiple signal (short time)
a1 = 2; a2 = 3; a3 = 3;
F1 = 1000; F2 = 2000; F3 = 3000;
t4 = 0:1/fs:0.01;
x1 = a1*sin(2*pi*F1*t4) + a2*cos(2*pi*F2*t4) + a3*sin(2*pi*F3*t4);
N5 = length(x1);
X5 = zeros(1, N5);
f_vals4 = (fs * (0:N5-1)) / N5;

for k = 0:N5-1
    for n = 0:N5-1
        X5(k+1) = X5(k+1) + x1(n+1) * exp(-1i * 2 * pi * k * n / N5);
    end
end

fig5 = figure;
subplot(3, 1, 1);
stem(t4, abs(x1), 'k', 'LineWidth', 0.1);
title('3.c.1.Multiple Signals');
xlabel('Time(s)');
ylabel('Amplitude');
grid on;

subplot(3, 1, 2);
stem(f_vals4, abs(X5), 'k', 'LineWidth',1);
title('Magnitude of DFT of Multiple Signals');
xlabel('Frequency');
ylabel('Amplitude');
grid on;

subplot(3, 1, 3);
stem(f_vals4, angle(X5), 'k', 'LineWidth', 0.1);
title('Phase angle of DFT of Multiple Signals');
xlabel('Frequency');
ylabel('Amplitude');
grid on;
saveas(fig5, '3c1_multiple_signals_dft_short.png');

% 3.c.2 with t = 0:1/fs:0.05
t5 = 0:1/fs:0.05;
x2 = a1*sin(2*pi*F1*t5) + a2*cos(2*pi*F2*t5) + a3*sin(2*pi*F3*t5);
N6 = length(x2);
X6 = zeros(1, N6);
f_vals5 = (fs * (0:N6-1)) / N6;

for k = 0:N6-1
    for n = 0:N6-1
        X6(k+1) = X6(k+1) + x2(n+1) * exp(-1i * 2 * pi * k * n / N6);
    end
end

fig6 = figure;
subplot(3, 1, 1);
stem(t5, abs(x2), 'k', 'LineWidth', 0.1);
title('3.c.2.Multiple Signals with t=0:1/fs:0.05');
xlabel('Time(s)');
ylabel('Amplitude');
grid on;

subplot(3, 1, 2);
stem(f_vals5, abs(X6), 'k', 'LineWidth', 1);
title('Magnitude of DFT of Multiple Signals');
xlabel('Frequency');
ylabel('Amplitude');
grid on;

subplot(3, 1, 3);
stem(f_vals5, angle(X6), 'k', 'LineWidth', 0.1);
title('Phase angle of DFT of Multiple Signals');
xlabel('Frequency');
ylabel('Amplitude');
grid on;
saveas(fig6, '3c2_multiple_signals_dft_long.png');
