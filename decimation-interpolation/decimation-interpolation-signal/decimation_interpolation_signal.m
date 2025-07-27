%Decimation & Interpolation for a signal
disp('Decimation & Interpolation for a signal');
f = 1000;
fsamp = 10000;
t = 0:(1/fsamp):2/f;
x = sin(2*pi*f*t);
I = input('Enter the value of I: ');
D = input('Enter the value of D: ');

figure;
subplot(4,1,1); plot(t, x, 'k'); hold on;
stem(t, x, 'k'); xlabel('Time'); ylabel('Amplitude'); title('Input Signal'); axis tight;

q = length(x);
x1 = zeros(1, q * I);
k = 0;
for i = 1:q
    x1(i + k) = x(i);
    k = k + I - 1;
end
subplot(4,1,2); stem(x1, 'k');
xlabel('Time'); ylabel('Amplitude');
title(['Signal after Interpolation by a factor ' num2str(I)]); axis tight;

t1 = 0:(1/(I*fsamp)):2/f;
y1 = interp1(t, x, t1);
subplot(4,1,3); stem(x1, 'k'); hold on;
plot(y1, 'bd:'); xlabel('Time'); ylabel('Amplitude');
title(['Reconstructed Signal after Interpolation by a factor ' num2str(I)]); axis tight;
legend('Interpolated Signal', 'Reconstructed Signal');

k = 1;
x2 = zeros(1, ceil(q / D));
for i = 1:D:q
    x2(k) = x(i);
    k = k + 1;
end
subplot(4,1,4); stem(x2, 'k'); hold on;
plot(x2, 'k'); xlabel('Time'); ylabel('Amplitude');
title(['Signal after Decimation by a factor ' num2str(D)]); axis tight;

% Save PNG
saveas(gcf, 'decimation_interpolation_signal.png');
