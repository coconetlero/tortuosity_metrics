function [TD, X, Y] = tortuosityDensity(X,Y,t)
    % Computes the Tortuosity Density (TD) Tortuosity Measure on a 2D curve 
    % represented as a (X,Y) verctor. 
    % This measure was firstly proposed by Grisan
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

    n = 0;
    L = [];
    np = length(X);
    sign_deriv = sign(dyy(1));    
    
    %% divide curve into n turn curves
    i_start = 1;
    i_end = 1;
    for i = 2:length(dyy)
        sign_i = sign(dyy(i));
        if (sign_i == 0)
            continue
        end
        if (sign_deriv == 0)
            sign_deriv = sign_i;
        end
        if (sign_deriv ~= sign_i || i == length(dyy))    
            sign_deriv = sign_i;
            i_end = i;
            if i_end - i_start < 2
                i_start = i;
                continue
            end

            Lt = DM(X(i_start:i_end),Y(i_start:i_end));

            if  Lt > 1e-4
%                 hold on, plot(X(i_end),Y(i_end), '*r');
                n = n+1;
                L(n) = Lt;
                i_start = i;
            end
        end
    end
    
    if (i_start ~= np)
        Lt = DM(X(i_start:np), Y(i_start:np));
        n = n+1;
        L(n) = Lt;
    end

    L_c = arclength(X,Y);    
    TD = ((n - 1) / n) * (1 / L_c) * sum(L);
    Y = dyy;
end


function Lt = DM(X,Y)
    L_c = arclength(X,Y);
    L_x = sqrt((X(1) - X(end))^2 + (Y(1) - Y(end))^2);
    Lt = (L_c / L_x) - 1;
end
