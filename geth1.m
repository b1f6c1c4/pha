function [b] = geth1(fs, Nh1)

%% Filter design
b = firls(Nh1-1, [0 10 50 fs/2]./(fs/2), [0 10 0 0], [1 100], 'differentiator');

%% Plot
clf;
hold on;
grid on;
plot([0 10 0 10 10], [10 10 0 10 0], 'k');

[X,w] = freqz(b, 1, 8192);
XX = X.*exp(w.*1j.*(Nh1-1)/2);
plot(w.*(fs/2/pi), imag(XX));
axis([0 100 -20 40]);

[X,w] = freqz([1,0,-1].*(fs/(4*pi)), 1, 8192);
XX = X.*exp(w.*1j.*2/2);
plot(w.*(fs/2/pi), imag(XX));

end
