function [phasor, frequency, rocof]=pmu(f0, fs, Data, h0)
% Phasor measurement unit
%
% Input:
%    f0:       Base frequency, Hz
%    fs:       Sampling frequency, Hz
%    Data:     L*3 array, where L = T*fs
%        (:,1) is phase A instant signal
%        (:,2) is phase B instant signal
%        (:,3) is phase C instant signal
%    h0:       FIR low-pass filter of order fs/f0 - 1
%
% Output:
%    phasor:    Instant positive-order phasor
%    frequency: Instant frequency
%    rocof:     Rate of change of frequency

%% Parameters
L  = size(Data,1); % Length of samples
T  = L / fs;       % Total sampling time, second
Ts = 1 / fs;       % Sampling period, second

%% Filters
h1 = [1,0,-1].*(fs/(4*pi));   % First-order differential
h2 = [1,-2,1].*(fs^2/(2*pi)); % Second-order differential

%% Oscillator
t   = (0 : Ts : T-Ts).';
osc = exp(-(2j*pi*f0).*t);
% This trick works only after Matlab R2016b.
% See the release note for more detail.
% To run the code in older versions,
% please use `bsxfun' instead.
DataO = osc .* Data;

%% Low-pass filter
Xabc = sqrt(2) .* fftfilt(h0, DataO); % h0 is applied to each columns

%% Three-phase phasor decomposition
alp = exp((2j*pi/3) .* [0 1 2]) ./ 3;
Xp  = Xabc * alp.';
phi = unwrap(angle(Xp));

%% Output
phasor    = Xp;
frequency = fftfilt(h1, phi);
rocof     = fftfilt(h2, phi);

end
