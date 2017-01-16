function [TVE, FE, RFE]=err(fs, Nh0, Nh1, phasor0, frequency0, rocof0, phasor, frequency, rocof, plotting)
% Error calculation
%
% Input:
%    fs:   Sampling frequency, Hz
%    Nh0:        Length of the FIR filter h0
%    Nh1:        Length of the FIR filter h1
%    phasor0:    Instant positive-order phasor
%    frequency0: Instant frequency
%    rocof0:     Rate of change of frequency
%    phasor:     Instant positive-order phasor
%    frequency:  Instant frequency
%    rocof:      Rate of change of frequency
%    plotting:
%        'no':   don't plot
%        'yes':  plot in the current figure
%        other:  save to that file
%
% Output:
%    TVE: Total vector error
%    FE: Frequency error
%    RFE: ROCOF error
%
% Note: Output is the max value

%% Alignment
N  = length(phasor0);
t0 = Nh0/2 + Nh1 + 1 : N - Nh0/2 + 1;
t1 = Nh0   + Nh1     : N;

%% Instant error
tTVE = abs(phasor(t1)    - phasor0(t0)   ) ./ abs(phasor0(t0));
tFE  = abs(frequency(t1) - frequency0(t0));
tRFE = abs(rocof(t1)     - rocof0(t0)    );

%% Max error
TVE  = max(tTVE);
FE  = max(tFE);
RFE = max(tRFE);

%% Plot
if (strcmp(plotting, 'no'))
    return;
end

L  = length(phasor0);
T  = L / fs;
Ts = 1 / fs;
t  = (0 : Ts : T-Ts).';
t  = t(t0);

if (strcmp(plotting, 'yes'))
    fh = figure;
end

clf;

%% Phasor
subplot(1,2,1);
cla;
hold on;
plot(t, real(phasor0(t0)), '');
plot(t, real(phasor(t1)), '-');
plot(t, imag(phasor0(t0)), '');
plot(t, imag(phasor(t1)), '-');
xlabel('t/s');
ylabel('Phasor');
legend('Re', 'Re(est.)', 'Im', 'Im(est.)');

%% Frequency
subplot(1,2,2);
cla;
hold on;
plot(t, phasor0(t0), '');
plot(t, phasor(t1), '-');
xlabel('t/s');
ylabel('Frequency Offset/Hz');
legend('\Delta f', '\Delta f(est.)');

end
