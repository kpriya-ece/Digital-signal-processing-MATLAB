x = [1, 2, 3, 4]; % Example input signal
len = length(x);
N = 2^nextpow2(len);        % Ensure length is power of 2
x = [x, zeros(1, N - len)]; % Zero-padding

% Manual DFT
X = zeros(1, N);
for k = 0:N-1
    for n = 0:N-1
        X(k+1) = X(k+1) + x(n+1) * exp(-1i * 2 * pi * k * n / N);
    end
end

% Built-in FFT
X1 = fft(x);

% Frequency axis
fv = (0:N-1) / N;

% Plotting
subplot(4,1,1); stem(abs(x), 'k'); title("x(n)"); xlabel("time"); ylabel("amplitude");
subplot(4,1,2); stem(fv, abs(X), 'k'); title("Manual DFT |X(k)|"); xlabel("frequency"); ylabel("magnitude");
subplot(4,1,3); stem(fv, abs(X1), 'k'); title("Built-in FFT |X1(k)|"); xlabel("frequency"); ylabel("magnitude");
subplot(4,1,4); plot(angle(X1), 'k'); title("Phase of FFT"); xlabel("frequency"); ylabel("angle");

% Save the figure as a PNG
saveas(gcf, 'dft_vs_fft_output.png');
