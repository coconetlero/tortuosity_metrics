function [Tc, X, Y] = totalCurvature(X, Y, t)
    % Computes the Total Curvature Tortuosity Measure on a 2D curve represented 
    % as a (x, y) verctor. This measure was firstly proposed by Smebdy
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

    K = abs((dx .* dyy) - (dxx .* dy)) ./ (dx.^2 + dy.^2);    
    Tc = trapz(t,K);

    %%% 
    % routine to display the amount of tortuosity along the curve
    %%% 

%     figure(1)
%     clf
%     plot(X,Y, '.-w');
%     hold on   
%     plot_color(X, Y, log(K),jet,[],'Linewidth',2);
%     set(gca,'Color','k');
%     axis equal
end

