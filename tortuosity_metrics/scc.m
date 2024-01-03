function alpha = scc(X, Y)
    % Compute the Slope Change Code fot the discrete points represented as a
    % 2D vector (X,Y).

    diff_x = diff(X);
    diff_y = diff(Y);
    
    M = diff_y ./ diff_x;
    Theta = atan2d(diff_y, diff_x);
    alpha = diff(Theta);

    C = find(alpha >= 180 | alpha <= -180);
    for k = C
        alpha(k) = mod(alpha(k), sign(alpha(k)) * -360);
    end
    
    alpha = alpha/180;
end

