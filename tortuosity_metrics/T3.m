function [T3, X, Y] = T3(X,Y,t)
    % Computes the Tau_3 Tortuosity Measure on a 2D curve represented 
    % as a (x, y) verctor. This measure was firstly proposed by Hart
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
    K = (dx .* dyy - dxx .* dy).^2 ./ (dx.^2 + dy.^2).^3;  

    Tsc = trapz(t, K);
    T3 = Tsc;

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