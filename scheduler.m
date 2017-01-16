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

%% Actual data
acData = load('WavData.mat');

%% Prepare
format short;
!copy /b /y NUL "./Generated/data.txt"
diary('./Generated/data.txt');

%% h0 = Rect, h1 = Naive
disp('=============');
disp('h0=Rect, h1=Naive:');
test(h0Rect, h1Naive, 'rect-naive');

%% h0 = Trig, h1 = Naive
disp('=============');
disp('h0=Trig, h1=Naive:');
test(h0Trig, h1Naive, 'trig-naive');

diary off;

%% Subfunctions

function []=test(h0, h1, plotting)

    A0   = 1;
    phi0 = rand(1,1) * pi;
    ka   = 0;
    kx   = 0;
    fm   = 5;

    %% Sine wave, df = 0
    df   = 0;
    [Data, standard] = gen(f0, fs, L, df, A0, phi0, ka, kx, fm);
    [estimated]      = pmu(f0, fs, Data, h0, h1);
    [TVE, FE, RFE]   = err(fs, length(h0), length(h1), standard, estimated, [plotting '-s0']);
    disp(['df=0: TVE=' num2str(TVE*100) '% FE=' num2str(FE) 'Hz RFE=' num2str(RFE) 'Hz/s']);

    %% Sine wave, df = +1
    df   = +1;
    [Data, standard] = gen(f0, fs, L, df, A0, phi0, ka, kx, fm);
    [estimated]      = pmu(f0, fs, Data, h0, h1);
    [TVE, FE, RFE]   = err(fs, length(h0), length(h1), standard, estimated, [plotting '-sp1']);
    disp(['df=+1: TVE=' num2str(TVE*100) '% FE=' num2str(FE) 'Hz RFE=' num2str(RFE) 'Hz/s']);

    %% Sine wave, df = -1
    df   = -1;
    [Data, standard] = gen(f0, fs, L, df, A0, phi0, ka, kx, fm);
    [estimated]      = pmu(f0, fs, Data, h0, h1);
    [TVE, FE, RFE]   = err(fs, length(h0), length(h1), standard, estimated, [plotting '-sm1']);
    disp(['df=-1: TVE=' num2str(TVE*100) '% FE=' num2str(FE) 'Hz RFE=' num2str(RFE) 'Hz/s']);

    %% Sine wave, df = +2
    df   = +2;
    [Data, standard] = gen(f0, fs, L, df, A0, phi0, ka, kx, fm);
    [estimated]      = pmu(f0, fs, Data, h0, h1);
    [TVE, FE, RFE]   = err(fs, length(h0), length(h1), standard, estimated, [plotting '-sp2']);
    disp(['df=+2: TVE=' num2str(TVE*100) '% FE=' num2str(FE) 'Hz RFE=' num2str(RFE) 'Hz/s']);

    %% Sine wave, df = -2
    df   = -2;
    [Data, standard] = gen(f0, fs, L, df, A0, phi0, ka, kx, fm);
    [estimated]      = pmu(f0, fs, Data, h0, h1);
    [TVE, FE, RFE]   = err(fs, length(h0), length(h1), standard, estimated, [plotting '-sm2']);
    disp(['df=-2: TVE=' num2str(TVE*100) '% FE=' num2str(FE) 'Hz RFE=' num2str(RFE) 'Hz/s']);

    %% AM-FM
    df   = 0;
    ka   = 0.1;
    kx   = 0.1;
    [Data, standard] = gen(f0, fs, L, df, A0, phi0, ka, kx, fm);
    [estimated]      = pmu(f0, fs, Data, h0, h1);
    [TVE, FE, RFE]   = err(fs, length(h0), length(h1), standard, estimated, [plotting '-amfm']);
    disp(['AM-FM: TVE=' num2str(TVE*100) '% FE=' num2str(FE) 'Hz RFE=' num2str(RFE) 'Hz/s']);

end

end
