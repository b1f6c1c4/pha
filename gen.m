function [Data, phasor, frequency, rocof]=gen(f0, fs, L, df, A0, phi0, ka, kx, fm)
% Standard wave generation
%
% Input:
%    f0:   Base frequency, Hz
%    fs:   Sampling frequency, Hz
%    L:    Number of samples
%    df:   Frequency offset
%    A0:   Amplitude
%    phi0: Initial phase
%    ka:   Phase modulation amp.
%    kx:   Amplitude modulation amp.
%    fm:   Modulation frequency
%
% Output:
%    Data:      L*3 array, where L = T*fs
%        (:,1)  is phase A instant signal
%        (:,2)  is phase B instant signal
%        (:,3)  is phase C instant signal
%    phasor:    Instant positive-order phasor
%    frequency: Instant frequency
%    rocof:     Rate of change of frequency

%% Parameters
T  = L / fs;
Ts = 1 / fs;
wm = 2 * pi * fm;

%% Phase modulation
t  = (0 : Ts : T-Ts).';
ph = (2*pi*f0) .* t +        ... % Base frequency
     (2*pi*df) .* t +        ... % Frequency offset
     ka .* cos(wm.*t - pi) + ... % Phase modulation
     phi0;                       % Initial phase

%% Amplitude modulation
am = sqrt(2) .* A0 .*        ... % Base amplitude
     (1 + kx .* cos(wm.*t));     % Amplitude modulation

%% Data generation
Data = am .* cos(ph - (2*pi/3) .* [0 1 2]);

%% Standard output
q = t + 0.5/fs;
phasor = A0 .*                     ... % Base amplitude
     (1 + kx .* cos(wm.*q)) .*     ... % Amplitude modulation
     exp(1j .* (                   ... %
     (2*pi*df) .* q +              ... % Frequency offset
     ka .* cos(wm.*q - pi) +       ... % Phase modulation
     phi0));                           % Initial phase
frequency =                        ... %
     df +                          ... % Frequency offset
     -ka.*fm.*sin(wm.*q - pi);         % Phase modulation
rocof =                            ... %
     -(ka*wm*fm).*cos(wm.*q - pi);     % Phase modulation

end
