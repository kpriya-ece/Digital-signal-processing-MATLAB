
clc; clear; close all;
A = 2; 
f = 100; 
fs = 5000; 
t = 0:1/fs:0.01;  
x = A * sin(2*pi*f* t);  
random_signal = randn(1, length(t)); 
M = length(x); 
N = length(random_signal);
len = M + N - 1;      
y = zeros(1, len);  
for n = 1:len
    for k = 1:N
        if n-k+1 > 0 && n-k+1 <= M
            y(n) = y(n) + x(n-k+1) * random_signal(k);
        end
    end
end
figure;
subplot(3, 1, 1);
stem(t, x, 'k');
title('Sine Wave');xlabel('Time (s)');ylabel('Amplitude');
grid on;
subplot(3, 1, 2);
stem(t, random_signal, 'k');
title('Random Signal');xlabel('samples');ylabel('Amplitude');
grid on;
subplot(3, 1, 3);
stem(0:len-1, y, 'k');
title('Convolution');xlabel('Samples n');ylabel('Amplitude');
grid on;

saveas(gcf, 'convolution_sine_random_plot.png');
