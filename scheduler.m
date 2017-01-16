function []=scheduler()

%% Parameters
f0 = 50;
fs = 4800;
T  = 5;
L  = T * fs;

%% Filter design
N0 = fs / f0;

%% Low-pass
h0Rect = ones(N0,1);
h0Rect = h0Rect ./ sum(h0Rect);
h0Trig = N0 - abs(2.*(-N0/2 : N0/2-1) + 1);
h0Trig = h0Trig ./ sum(h0Trig);

%% First-order differential
h1Naive = [1,0,-1].*(fs/(4*pi));

%% h0 = Rect, h1 = Naive
test(h0Rect, h1Naive, 'rect-naive');

%% Subfunctions

function []=test(h0, h1, plotting)

    %% Sine wave, df = 0
    df   = 0;
    A0   = 1;
    phi0 = rand(1,1) * pi;
    ka   = 0;
    kx   = 0;
    fm   = 5;

    [Data, standard] = gen(f0, fs, L, df, A0, phi0, ka, kx, fm);
    [estimated]      = pmu(f0, fs, Data, h0, h1);
    [TVE, FE, RFE]   = err(fs, length(h0), length(h1), standard, estimated, [plotting '-s0']);

end

end
