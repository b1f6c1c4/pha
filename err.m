function [TVE, FE, RFE]=err(Nh0, Nh1, phasor0, frequency0, rocof0, phasor, frequency, rocof);
% Error calculation
%
% Input:
%    Nh0:        Length of the FIR filter h0
%    Nh1:        Length of the FIR filter h1
%    phasor0:    Instant positive-order phasor
%    frequency0: Instant frequency
%    rocof0:     Rate of change of frequency
%    phasor:     Instant positive-order phasor
%    frequency:  Instant frequency
%    rocof:      Rate of change of frequency
%
% Output:
%    TVE: Total vector error
%    FE: Frequency error
%    RFE: ROCOF error
%
% Note: Output is the max value

%% Alignment
N  = length(phasor0);
t0 = Nh0   + Nh1     : N;
t1 = Nh0/2 + Nh1 + 1 : N - Nh0/2 + 1;

%% Instant error
tTVE = abs(phasor(t1)    - phasor0(t0)   ) ./ abs(phasor0(t0));
tFE  = abs(frequency(t1) - frequency0(t0));
tRFE = abs(rocof(t1)     - rocof0(t0)    );

%% Max error
TVE  = max(tTVE);
tFE  = max(tFE);
tRFE = max(tRFE);

end
