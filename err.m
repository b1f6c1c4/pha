function [TVE, FE, RFE]=err(fs, Nh0, Nh1, standard, estimated, plotting)
% Error calculation
%
% Input:
%    fs:         Sampling frequency, Hz
%    Nh0:        Length of the FIR filter h0
%    Nh1:        Length of the FIR filter h1
%    standard:
%        phasor:    Instant positive-order phasor
%        frequency: Instant frequency
%        rocof:     Rate of change of frequency
%        phasorA:   Instant phasor of A
%        phasorB:   Instant phasor of B
%        phasorC:   Instant phasor of C
%    estimated:
%        phasor:    Instant positive-order phasor
%        frequency: Instant frequency
%        rocof:     Rate of change of frequency
%        phasorA:   Instant phasor of A
%        phasorB:   Instant phasor of B
%        phasorC:   Instant phasor of C
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
L  = length(standard.phasor);
t0 = Nh0/2 + Nh1 + 1 : L - Nh0/2 + 1;
t1 = Nh0   + Nh1     : L;

%% Instant error
tTVE = abs(estimated.phasor(t1)    - standard.phasor(t0)   ) ./ abs(standard.phasor(t0));
tFE  = abs(estimated.frequency(t1) - standard.frequency(t0));
tRFE = abs(estimated.rocof(t1)     - standard.rocof(t0)    );

%% Max error
TVE = max(tTVE);
FE  = max(tFE);
RFE = max(tRFE);

%% Plot
if (strcmp(plotting, 'no'))
    return;
end

T  = L / fs;
Ts = 1 / fs;
t  = (0 : Ts : T-Ts).';
t  = t(t0);

fh = figure;

%% Phasor
clf;
hold on;
plot(t, real(standard.phasor(t0)), '');
plot(t, real(estimated.phasor(t1)), '--');
plot(t, imag(standard.phasor(t0)), '');
plot(t, imag(estimated.phasor(t1)), '--');
xlabel('t/s');
ylabel('Positive-order Phasor');
legend('Re', 'Re(est.)', 'Im', 'Im(est.)');
saveas(fh, ['./Generated/' plotting '-phasor.eps'], 'epsc');

%% Phasors
clf;
hold on;
plot(t, real(standard.phasorA(t0)), '');
plot(t, real(estimated.phasorA(t1)), '--');
plot(t, imag(standard.phasorA(t0)), '');
plot(t, imag(estimated.phasorA(t1)), '--');
plot(t, real(standard.phasorB(t0)), '');
plot(t, real(estimated.phasorB(t1)), '--');
plot(t, imag(standard.phasorB(t0)), '');
plot(t, imag(estimated.phasorB(t1)), '--');
plot(t, real(standard.phasorC(t0)), '');
plot(t, real(estimated.phasorC(t1)), '--');
plot(t, imag(standard.phasorC(t0)), '');
plot(t, imag(estimated.phasorC(t1)), '--');
xlabel('t/s');
ylabel('Phasors');
legend( ...
    'A.Re', 'A.Re(est.)', 'A.Im', 'A.Im(est.)', ...
    'B.Re', 'B.Re(est.)', 'B.Im', 'B.Im(est.)', ...
    'C.Re', 'C.Re(est.)', 'C.Im', 'C.Im(est.)');
saveas(fh, ['./Generated/' plotting '-phasors.eps'], 'epsc');

%% Frequency
clf;
hold on;
plot(t, standard.frequency(t0), '');
plot(t, estimated.frequency(t1), '--');
xlabel('t/s');
ylabel('Frequency Offset/Hz');
legend('\Delta f', '\Delta f(est.)');
saveas(fh, ['./Generated/' plotting '-frequency.eps'], 'epsc');

close(fh);

end
