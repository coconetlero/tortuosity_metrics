function [DM, X, Y] = distanceMeasure(X, Y)
    % Computes the Distance Measure Tortuosity on a 2D curve represented as a (x, y) verctor, 
    % also called the arc-chord ratio
    %
    % arguments
    % X  -  X component vector coordinates.
    % Y  -  Y component vector coordinates.

    
    distances = sqrt(diff(X).^2 + diff(Y).^2);
    L_c = sum(distances);
    L_x = sqrt((X(1) - X(end))^2 + (Y(1) - Y(end))^2);

    DM = L_c / L_x;
end