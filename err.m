function [TVE, FE, RFE]=err(fs, Nh0, Nh1, phasor0, frequency0, rocof0, phasors0, phasor, frequency, rocof, phasors, plotting)
% Error calculation
%
% Input:
%    fs:         Sampling frequency, Hz
%    Nh0:        Length of the FIR filter h0
%    Nh1:        Length of the FIR filter h1
%    phasor0:    Instant positive-order phasor (ref.)
%    frequency0: Instant frequency             (ref.)
%    rocof0:     Rate of change of frequency   (ref.)
%    phasors0:   Instant phasor                (ref.)
%    phasor:     Instant positive-order phasor (est.)
%    frequency:  Instant frequency             (est.)
%    rocof:      Rate of change of frequency   (est.)
%    phasors0:   Instant phasor                (est.)
%    plotting:
%        'no':   don't plot
%        other:  save to that file
%
% Output:
%    TVE: Total vector error
%    FE:  Frequency error
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
TVE = max(tTVE);
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

fh = figure;

%% Phasor
clf;
hold on;
plot(t, real(phasor0(t0)), '');
plot(t, real(phasor(t1)), '--');
plot(t, imag(phasor0(t0)), '');
plot(t, imag(phasor(t1)), '--');
xlabel('t/s');
ylabel('Positive-order Phasor');
legend('Re', 'Re(est.)', 'Im', 'Im(est.)');
saveas(['./Generated/' plotting '-phasor.eps'], 'epsc');

%% Phasors
clf;
hold on;
plot(t, real(phasors0(t0,1)), '');
plot(t, real(phasors(t1,1)), '--');
plot(t, imag(phasors0(t0,1)), '');
plot(t, imag(phasors(t1,1)), '--');
plot(t, real(phasors0(t0,2)), '');
plot(t, real(phasors(t1,2)), '--');
plot(t, imag(phasors0(t0,2)), '');
plot(t, imag(phasors(t1,2)), '--');
plot(t, real(phasors0(t0,3)), '');
plot(t, real(phasors(t1,3)), '--');
plot(t, imag(phasors0(t0,3)), '');
plot(t, imag(phasors(t1,3)), '--');
xlabel('t/s');
ylabel('Phasors');
legend( ...
    'A.Re', 'A.Re(est.)', 'A.Im', 'A.Im(est.)', ...
    'B.Re', 'B.Re(est.)', 'B.Im', 'B.Im(est.)', ...
    'C.Re', 'C.Re(est.)', 'C.Im', 'C.Im(est.)');
saveas(['./Generated/' plotting '-phasors.eps'], 'epsc');

%% Frequency
clf;
hold on;
plot(t, frequency0(t0), '');
plot(t, frequency(t1), '--');
xlabel('t/s');
ylabel('Frequency Offset/Hz');
legend('\Delta f', '\Delta f(est.)');
saveas(['./Generated/' plotting 'frequency.eps'], 'epsc');

close(fh);

end
