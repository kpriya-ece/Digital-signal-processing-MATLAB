
clc; clear;close all;
A1 = 2;         
f1 = 1000;      
A2 = 3;         
f2 = 3000;      
fs = 50000;      
t = 0:1/fs:0.001;   
x = A1 * sin(2*pi*f1*t);
h = A2 * sin(2*pi*f2*t);
M = length(x); 
N = length(h);
len = M + N - 1;      
y= zeros(1, len);  
for n = 1:len
    for k = 1:N
        if n - k + 1 > 0 && n - k + 1 <= M
            y(n) = y(n) + x(n - k + 1) * h(k);
        end
    end
end
figure;
subplot(3, 1, 1);
stem(t, x, 'k');
title('Signal x[n]');xlabel('Time (s)');ylabel('Amplitude');
grid on;
subplot(3, 1, 2);
stem(t, h, 'k');
title('Signal h[n]');xlabel('Time (s)');ylabel('Amplitude');
grid on;
subplot(3, 1, 3);
stem(0:len-1, y, 'k');
title('Linear Convolution y[n]');xlabel('Samples n');ylabel('Amplitude');
grid on;

saveas(gcf, 'convolution_sine_signals_plot.png');
