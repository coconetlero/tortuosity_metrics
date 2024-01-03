function [SCC, X, Y] = sccMeasure(X, Y, norm)
    % Computes the Tortuosity on a 2D curve represented as a (x, y) verctor, 
    % based on the Slope Change Code.
    %
    % arguments
    % x  -  X component vector coordinates.
    % y  -  Y component vector coordinates.
    % norm  -  1 if the tortuosity needs to be curve lenght normalizated, 0 in other
    %          case. 

    arguments
        X (1,:) double
        Y (1,:) double
        norm int8 = 0
    end
        
    alpha = scc(X,Y);
    SCC = sum(abs(alpha));
    
    if (norm ~= 0)
        SCC = SCC / length(alpha);
    end
end 