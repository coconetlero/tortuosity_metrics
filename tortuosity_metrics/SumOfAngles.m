function [SOAM, X, Y] = SumOfAngles(X,Y)
    % Computes the Sum Of Angles Metric (SOAM) Tortuosity Measure on a 2D curve 
    % represented as a (X,Y) verctor. 
    % This measure was firstly proposed by Bullitt
    %
    % arguments
    % x  -  X component vector coordinates.
    % y  -  Y component vector coordinates.
        
    distances = sqrt(diff(X).^2 + diff(Y).^2);
    L_c = sum(distances);

    diff_x = diff(X);
    diff_y = diff(Y);
            
    Theta = atan2d(diff_y, diff_x);
    alpha = diff(Theta);
    SOAM = sum(abs(alpha)) / L_c;
end

