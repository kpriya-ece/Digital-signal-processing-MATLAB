clear; clc; close all;

% Generation of desired signal
f = 1000; fsamp = 10000;
t = 0:1/fsamp:0.01;
d = 2 * sin(2 * pi * f * t);

subplot(4, 1, 1), plot(d, 'k'); title('Desired signal'); axis tight;

% Generation of corrupted signal
N = numel(d);  % Number of elements
x = d + 0.5 * randn(1, N);
subplot(4, 1, 2), plot(x, 'k'); title('Signal corrupted with noise'); axis tight;

% LMS Adaptive filtering
mu = 0.002;
M = 256;
nk = 0:N-1;
u = zeros(M, 1);
w = zeros(M, 1);
y = zeros(1, N);
e = zeros(1, N);

for n = 1:N
    u = [x(n); u(1:end-1)];
    y(n) = w' * u;
    e(n) = d(n) - y(n);
    w = w + mu * e(n) * u;
end

subplot(4, 1, 3); plot(nk, d, 'k', nk, y, '--k'); title('Estimated signal');
legend('Desired', 'Estimated');
subplot(4, 1, 4); plot(nk, e.^2, 'k'); title('Error signal');

% Save the figure as PNG
saveas(gcf, 'lms_adaptive_filter.png');
