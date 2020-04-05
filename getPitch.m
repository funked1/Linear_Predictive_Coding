%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Filename:    getPitch.m
% Description: Function to detect the pitch of a given speech sample
% Input:
%              inSignal:   (vector) sound signal
%              sampFreq:   (scalar) sampling frequency
%              winSize:    (scalar) size of subsample windows
%              overlap:    (scalar) percent overlap between
%                                   subsample windows (decimal)
% Output:
%              Bs:         (scalar) Optimal pitch gain
%              Ms:         (scalar) Optimal pitch period
% Author:      Dan Funke
% Created:     4/26/2019
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Bs, Ms] = getPitch(inSignal, sampFreq, winSize, overlap)
    L = length(inSignal)  ;                 % Length of input signal
    Ws = winSize * (sampFreq/1000);
    Ol = Ws * overlap;                      % Size of overlap
    Nf = floor(L / Ws);                     % Number of segments
    Fn = sampFreq / 2;                      % Nyquist frequency
    normSig = inSignal / max(inSignal);     % Normalize sample amplitudes

    Bs = [];
    Ms = [];

    for i=1:Nf
        seg = normSig(1 + (Ws *(i - 1)):Ws * i).*hamming(Ws);
        [B, M] = ltp(seg);
        Bs = [Bs, B];
        Ms = [Ms, M];
    end
end
