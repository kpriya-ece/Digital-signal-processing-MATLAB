x = input('Enter the first sequence: ');
h = input('Enter the second sequence: ');

figure;
subplot(4, 1, 1);
stem(x, 'k');
xlabel('Samples'); ylabel('Amplitude'); title('x[n]');

subplot(4, 1, 2);
stem(h, 'k');
xlabel('Samples'); ylabel('Amplitude'); title('h[n]');

lx = length(x);
lh = length(h);

% Overlap Save
k = ceil(lx / (lh - 1));  
x_p = [zeros(1, lh - 1), x, zeros(1, (lh - 1) * (k - 1))];  
y = [];

for i = 1:k
    x_s = x_p((i - 1)*(lh - 1) + 1 : (i - 1)*(lh - 1) + lx + lh - 1);
    y_s = convolution(x_s, h);  
    y = [y, y_s(lh:end)];  
end

y = y(1:lx + lh - 1);  

subplot(4, 1, 3);
stem(y, 'k');
xlabel('Samples'); ylabel('Amplitude'); title('Overlap Save');

% Overlap Add
k = ceil(lx / lh);
x1 = [x, zeros(1, (lh * k) - lx)];
y2 = zeros(k, length(x1) + lh - 1); 

for i = 1:k
    x3 = [x1((lh * (i - 1) + 1):lh * i), zeros(1, lh - 1)];
    y1 = convolution(x3, h);  
    y2(i, 1:length(y1) + lh * (i - 1)) = [zeros(1, lh * (i - 1)), y1];
end

z = sum(y2, 1);
z = z(1:lx + lh - 1); 
subplot(4, 1, 4);
stem(z, 'k');
xlabel('Samples'); ylabel('Amplitude'); title('Overlap Add');

function y = convolution(x, h)
    M = length(x); 
    N = length(h);
    len = M + N - 1;
    y = zeros(1, len);
    
    for n = 1:len
        for k = 1:N
            if n - k + 1 > 0 && n - k + 1 <= M
                y(n) = y(n) + x(n - k + 1) * h(k);
            end
        end
    end
end
saveas(gcf, 'overlap_methods_plot.png');
