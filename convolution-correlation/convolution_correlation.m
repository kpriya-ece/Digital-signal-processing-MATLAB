% Input signals
x = [1, 2, 3, 4]; 
h = [1, 0, 0, 1];  

M = length(x); 
N = length(h);
len = M + N - 1;  
% --- Linear Convolution ---
y_l = zeros(1, len);
for n = 1:len
    for k = 1:N  
        if n - k + 1 > 0 && n - k + 1 <= M  
            y_l(n) = y_l(n) + x(n - k + 1) * h(k);
        end
    end
end

% --- Circular Convolution ---
x_p = [x, zeros(1, len - M)];
h_p = [h, zeros(1, len - N)];

y_c = zeros(1, len);
for n = 1:len
    for k = 1:len
        y_c(n) = y_c(n) + x_p(mod(n - k, len) + 1) * h_p(k);
    end
end

% --- Correlation ---
h_flipped = fliplr(h);  
y_corr = zeros(1, len);
for n = 1:len
    for k = 1:N
        if (n - k + 1) > 0 && (n - k + 1) <= M
            y_corr(n) = y_corr(n) + x(n - k + 1) * h_flipped(k); 
        end
    end
end

% --- Plotting ---
figure;

subplot(3, 2, 1);
stem(0:M-1, x, 'k'); 
title('x[n]'); xlabel('Samples n'); ylabel('Amplitude');

subplot(3, 2, 2);
stem(0:N-1, h, 'k'); 
title('h[n]'); xlabel('Samples n'); ylabel('Amplitude');

subplot(3, 2, 3);
stem(0:len-1, y_l, 'k'); 
title('Linear Convolution y[n]'); xlabel('Samples n'); ylabel('Amplitude');

subplot(3, 2, 4);
stem(0:len-1, y_c, 'k');
title('Circular Convolution y[n] (padded)'); xlabel('Samples n'); ylabel('Amplitude');

subplot(3, 2, 5);
stem(0:len-1, y_corr, 'k');
title('Correlation'); xlabel('Samples n'); ylabel('Amplitude');

% Save plot
saveas(gcf, 'convolution_correlation_plot.png');
