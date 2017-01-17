function [b] = geth0(f0, fs, Nh0)

%% Filter design
b = firls(Nh0-1, [0 5 f0/2 fs/2]./(fs/2), [1 1 0.05 0], [10 1]);
b = b ./ sum(b);

%% Plot
clf;
hold on;
plot([0 5 5], [-0.1 -0.1 -100], 'k');
plot([0 f0/2 f0/2 fs/2], [+0.1 +0.1 -20 -20], 'k');

[X,w] = freqz(b, 1, 8192);
plot(w.*(fs/2/pi), 20.*log10(abs(X)));
axis([0 f0 -30 1]);

end
