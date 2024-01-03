function [asdc, X, Y] = ASDC(X,Y,t)
    % Average Squared-Derivative Curvature (ASDC) Tortuosity Measure on
    % a 2D curve represented as a (X,Y) verctor. 
    % This measure was firstly proposed by Kashyap
    %
    % arguments
    % x  -  X component vector coordinates.
    % y  -  Y component vector coordinates.
    % t  -  a vector of the same size of X represented an alternative
    %       parametrization. Leave empty if an arclength parametrization must
    %       be used.
    
   
    if ~exist('t','var')      
        t = cumtrapz(sqrt(gradient(X).^2 + gradient(Y).^2));
    end
    
    [dx, dy, dydx, dxdy, dxx, dyy, dyydx, dxxdy] = SplineDerivatives(X,Y,t);          
    K = dx .* dyy - dxx .* dy ./ (dx.^2 + dy.^2).^(3/2);
   

    dKdt = DGradient(K, X, 2, '2ndOrder');
    n = find(isnan(dKdt));
    dKdt(n) = 0;

    dKdt2 = dKdt.^2;
    Tdc = trapz(X, dKdt2);
    L_c = arclength(X,Y);

    asdc = Tdc/L_c;

end
