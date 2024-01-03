function [ICM,X,Y] = InflectionCountMetric(X,Y,t)
    % Computes Inflection Count Metric (ICM) Tortuosity Measure on a 2D 
    % curve represented as a (x, y) verctor. 
    % This measure was firstly proposed by Bullitt
    %
    % arguments
    % x  -  X component vector coordinates.
    % y  -  Y component vector coordinates.
    % t  -  a vector of the same size of X represented an alternative
    %       parametrization. Leave empty if an arclength parametrization must
    %       be used.
   
    if ~exist('t','var')      
        t = cumsum(sqrt(gradient(X).^2 + gradient(Y).^2));
    end

    [dx, dy, dydx, dxdy, dxx, dyy, dyydx, dxxdy] = SplineDerivatives(X,Y,t);   

    %% count inflection points
    n = 0;
    sign_deriv = sign(dyy(1));    
    i_start = 1;    
    for i = 2:length(dyy)        
        sign_i = sign(dyy(i));
        if (sign_i == 0)
            continue
        end
        if (sign_deriv == 0)
            sign_deriv = sign_i;
        end
        if (sign_deriv ~= sign_i)    
            sign_deriv = sign_i;
            i_end = i;
            if i_end - i_start < 2
                i_start = i;
                continue
            end

            Lcs_i = arclength(X(i_start:i_end),Y(i_start:i_end));
            Lxs_i = sqrt((X(i_start) - X(i_end))^2 + (Y(i_start) - Y(i_end))^2);
            Lt = (Lcs_i / Lxs_i) - 1;

            if  Lt > 1e-4
                n = n+1;
            end

            i_start = i-1;
        end
    end
    
    dm = distanceMeasure(X,Y);
    ICM = (n+1) * dm;

end

