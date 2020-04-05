clear
clc

%% Constants
soundfile = 'SX110.WAV';
epdSensitivity = 2;
windowSize = 20;
percentOverlap = 0.5; % 50 percent overlap

%% Endpoint detection
[inSignal, Fs] = audioread(soundfile);
truncSignal = epd(inSignal, epdSensitivity);

%% Preemphasis of speech signal
H = [1, -0.9375];
empSig = filter(H, 1, truncSignal);

%% determine LPC for Hamming segments
[lpcCoEffs, numSegs] = getLPC(empSig, Fs, windowSize, percentOverlap);

%% determine Zero Crossings for each segment
zeroCross = getZCR(empSig, Fs, windowSize, percentOverlap);

%% determine pitch parameters
[Bs, Ms] = getPitch(empSig, Fs, windowSize, percentOverlap);

%% Plots
subplot(3, 1, 1);
plot(inSignal);
xlabel('Samples (s)');
ylabel('Amplitude');
title('Original Speech Signal')
grid

subplot(3,1,2);
plot(truncSignal);
xlabel('Samples (s)');
ylabel('Amplitude');
title('Speech Signal -(without initial silence and ending silence)')
grid

subplot(3,1,3);
plot(empSig);
xlabel('Samples (s)');
ylabel('Amplitude');
title('Speech Signal with Applied Pre-emphasis Filter')
grid
