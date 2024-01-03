function [T5, X, Y] = T5(X,Y,t)
    % Computes the Tau_5 Tortuosity Measure on a 2D curve represented 
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
    
    Tsc = T3(X,Y,t);      
    L_c = arclength(X,Y);
    T5 = Tsc / L_c;
end



