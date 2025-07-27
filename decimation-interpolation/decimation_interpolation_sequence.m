clc; clear all; close all;

%Decimation & Interpolation for the sequence
disp('Decimation & Interpolation for the sequence');
x = input('Enter the signal sequence: ');
q = length(x);
I = input('Enter the value of I: ');
D = input('Enter the value of D: ');

figure;
subplot(3,1,1); stem(x, 'k'); title('Input Sequence');

% Interpolation
x_int = zeros(1, q * I);
k = 0;
for i = 1:q
    x_int(i + k) = x(i);
    k = k + I - 1;
end
subplot(3,1,2); stem(x_int, 'k');
title('Signal after Interpolation'); xlabel('Samples'); ylabel('Magnitude');

% Decimation
k = 1;
x_dec = zeros(1, ceil(q / D));
for i = 1:D:q
    x_dec(k) = x(i);
    k = k + 1;
end
subplot(3,1,3); stem(x_dec, 'k');
title('Signal after Decimation'); xlabel('Samples'); ylabel('Magnitude');

% Save PNG
saveas(gcf, 'decimation_interpolation_sequence.png');

