function [dx, dy, dydx, dxdy, dxx, dyy, dyydx, dxxdy] = SplineDerivatives(X, Y, t)
    % SPLINEDERIVATIVES Find the fisrt and second derivatives of parametric
    % plane curves based ona spline construction from a (X,Y) vector
    %
    % arguments
    %
    % x  -  X component vector coordinates.
    % y  -  Y component vector coordinates.
    % t  -  a vector of the same size of X represented an alternative
    %       parametrization. Leave it empty and constant length parametrization 
    %       must be used.

    if ~exist('t','var')         
          t = 1:length(X);
    end

    fx = spline(t,X);
    fy = spline(t,Y);    

    d1fx = differentiate(fx);
    d1fy = differentiate(fy);    
    d2fx = differentiate(d1fx);
    d2fy = differentiate(d1fy);

    ti = linspace(min(t),max(t),length(X));
    
    dx = ppval(d1fx,ti);
    dy = ppval(d1fy,ti);
    dxx = ppval(d2fx,ti);
    dyy = ppval(d2fy,ti);
    
    dx(abs(dx)<1e-12) = 0;
    dy(abs(dy)<1e-12) = 0;
    dxx(abs(dxx)<1e-12) = 0;
    dyy(abs(dyy)<1e-12) = 0;
    
    dydx = dy./dx;     
    dyydx = dyy ./ dx.^2;
    dxdy = dx ./ dy;                
    dxxdy = dxx ./ dy.^2;
    
end

function ppdf = differentiate(ppf)
    % Spline Derivative
    ppdf = ppf;
    ppdf.order=ppdf.order-1;
    ppdf.coefs=ppdf.coefs(:,1:end-1).*(ppdf.order:-1:1);
end

