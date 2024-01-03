function [ESCC, Xe, Ye] = esccMeasure(X, Y, norm)
    % Computes the Tortuosity on a 2D curve represented as a (x, y) verctor, 
    % based on the Exteded Slope Change Code.
    %
    % arguments
    % X  -  X component vector coordinates.
    % Y  -  Y component vector coordinates.
    % norm  -  1 if the tortuosity needs to be curve lenght normalizated, 0 in other
    %          case. 

    arguments
        X (1,:) double
        Y (1,:) double    
        norm int8 = 0
    end
        
    [Xe,Ye] = escc(X,Y);
    alpha = scc(Xe,Ye);
    ESCC = sum(abs(alpha));

    if (norm ~= 0)
        ESCC = ESCC / length(alpha);
    end
    
    if all(Xe == -1) && all(Ye == -1)
        ESCC = -1;
    end

end
