%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Filename:    epd.m
% Description: Function to detect the endpoint of a signal
%              and eliminate silence at beginning and end 
%              of a sound file.
% Input:
%              inSignal:   (vector) sound signal
%              minPercent: (scalar) truncation threshold percent
% Output: 
%              outSignal:  (vector) truncated signal
% Author:      Dan Funke
% Created:     4/26/2019
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[outSignal] = epd(inSignal, minPercent)

    % Validate input parameters
    msg = 'Error occurred. \n Input must be a %s, not a %s';
    if ~isvector(inSignal)
        error(msg, 'vector', class(inSignal))
    end
    
    if ~isscalar(minPercent)
       error(msg, 'scalar', class(minPercent))
    end
    
    if minPercent <= 0
       error('minPercent must be a positive value')
    end
    
    threshold = minPercent * (max(inSignal)/100);
    sigStart = 1;
    sigEnd   = length(inSignal);
    
    % Compare signal values to calculated threshold. Assign start value
    % to signal position immediately proceeding first suprathreshold value
    for i = 1:length(inSignal)
        if(abs(inSignal(i)) > threshold)
            if(i > 1)
                sigStart = i - 1;
            else
                sigStart = 1;
            end
            break
        end
    end
    
    % Compare signal values to calculated threshold. Assign end value
    % to signal position immediately following last suprathreshold value
    for i = length(inSignal):-1:1
        if(abs(inSignal(i)) > threshold)
            if(i > 1)
                sigEnd = i + 1;
            else
                sigEnd = 1;
            end
            break
        end
    end
    
    % Truncate beginning and end of signal using new start and end points
    outSignal = inSignal(sigStart:sigEnd);
    
end