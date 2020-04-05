%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Filename:    getLPC.c
% Description: Function to generate the linear predictive coefficients
               of a given sample
% Input:
%              inputVector:   (vector) sample data
%              Fs:            (scalar) sampling frequency
%              windowSize:    (scalar) window size
%              overLap:       (scalar) overlap between windows
% Output:
%              outputMatrix:  (matrix) matrix of coefficients
%              numSegs:       (scalar) number of segments
% Author:      Dan Funke
% Created:     4/26/2019
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[outputMatrix, numSegs] = getLPC(inputVector, Fs, windowSize, overLap)

    % Segementation Parameters
    ws = (windowSize * Fs) / 1000;
    ol = ((windowSize * overLap) * Fs) / 1000;

    % set temp as empty vector
    temp = [];

    i = 1; % vector index
    numSegs = 1; % segment number
    while (i + ws + 1) <= length(inputVector)
        % segment input signal using Hamming windows
        seg = inputVector(i:(i + ws - 1)); %segment to be processed
        hammingSeg = seg .* hamming(ws);

        % get LPC coefficients for hammingSeg
        lpcCoEff = lpc(hammingSeg, 10);
        temp = [temp, lpcCoEff];

        i = i + ol; % shift vector index to next segment
        numSegs = numSegs + 1;  % increment frame pointer
    end

    % Construct output matrix
    n = 1;
    outputMatrix = zeros(numSegs - 1, 11);
    for i = 1:1:(numSegs - 1)
       for j = 1:1:11
           outputMatrix(i, j) = temp(n);
           n = n + 1;
       end
    end
end
