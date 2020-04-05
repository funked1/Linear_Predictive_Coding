%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Filename:    getZCR.m
% Description: Function to determine the number of zero crossings in
%              each windowed subsection
% Input:
%              inputVector:   (vector) sound signal
%              Fs:            (scalar) Sampling frequency
%              windowSize:    (scalar) Size of subsections
%              overLap:       (scalar) percent overlap between
%                                      subsample windows (decimal)
% Output:
%              outSignal:  (vector) number of zero crossings in each window
% Author:      Dan Funke
% Created:     4/26/2019
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[outputVector] = getZCR(inputVector, Fs, windowSize, overLap)

    % Segementation Parameters
    ws = (windowSize * Fs) / 1000;
    ol = ((windowSize * overLap) * Fs) / 1000;

    i = 1; % vector index
    n = 1;
    while (i + ws + 1) <= length(inputVector)
        % segment input signal using Hamming windows
        seg = inputVector(i:(i + ws - 1)); %segment to be processed
        hammingSeg = seg .* hamming(ws);

        outputVector(n) = zcr(hammingSeg);

        i = i + ol; % shift vector index to next segment
        n = n + 1;
    end

end
