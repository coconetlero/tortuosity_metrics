function [Xe,Ye] = escc(X,Y)
    % Compute the Extended Slope Change Code fot the discrete points represented as a
    % 2D vector (X,Y).

    Xe(1:2) = X(1:2);
    Ye(1:2) = Y(1:2);

    vx = X(2) - X(1); 
    vy = Y(2) - Y(1);

    L_x = mean(sqrt(diff(X).^2 + diff(Y).^2));
    
    M = atan2d(vy, vx);

    x_0 = X(1);
    y_0 = Y(1);
    P = [x_0; y_0];
    
    idx = 1;
    io = 1;
    
    try
       while (idx > 0) && (idx < length(X))

            Xe(io) = x_0;
            Ye(io) = y_0;
            io = io+1;

            alpha = deg2rad(M);
            theta = linspace(alpha, alpha+pi, 180);
            Xp = x_0 + (L_x * (1-((theta - alpha) / pi))) .* cos(theta);
            Yp = y_0 + (L_x * (1-((theta - alpha) / pi))) .* sin(theta);

            theta = linspace(alpha, alpha-pi, 180);
            Xn = x_0 + (L_x * (1+((theta - alpha) / pi))) .* cos(theta);
            Yn = y_0 + (L_x * (1+((theta - alpha) / pi))) .* sin(theta);

            Xt = [Xp(end:-3:1),Xn];
            Xt = Xt(2:end-3);
            Yt = [Yp(end:-3:1),Yn];
            Yt = Yt(2:end-3);

    %         plot_data_2(Xt, Yt);

            intersec = true;
            n = 1;
            m = 0;
            while(intersec)
                if (idx < 1)
                elseif (idx < length(X))
                    Xl = [X(idx) X(idx+1)];
                    Yl = [Y(idx) Y(idx+1)];
    %                 plot_line_2(Xl,Yl)
                else
                    intersec = false;
                end

                [xi,yi] = polyxpoly(Xl, Yl, Xt, Yt);
                if xi
                    if length(xi) > 1
                        [maxd,j] = max(sqrt((x_0 - xi).^2 + (y_0 - yi).^2));
                        x_1 = xi(j);
                        y_1 = yi(j);
                    else
                        x_1 = xi(1);
                        y_1 = yi(1);
                    end
                    intersec = false;
                else
                    if n ~= m 
                        if (idx + n) < length(X)    
                            m = m + 1;
                            idx = idx + m;
                            n = n + 1;
                            m = n;
                        else
                            if (sqrt((X(idx) - X(idx+1))^2 + (Y(idx) - Y(idx+1))^2)) < (sqrt((Xp(1) - Xp(end))^2 + (Yp(1) - Yp(end))^2))
                                intersec = false;
                                break;
                            else
                                idx = idx - n;
                            end
                        end
                    else
                        idx = idx - n;
                        n = n + 1;
                    end
                end
            end

            vx = x_1 - x_0; 
            vy = y_1 - y_0;
            M = atan2d(vy, vx);

            idx = idx + 1;

            x_0 = x_1;
            y_0 = y_1;
        end

        Xe(io) = X(end);
        Ye(io) = Y(end);
    catch 
        Xe = -1 + zeros( 1, length(X));
        Ye = -1 + zeros( 1, length(Y));
        return 
    end
end

%%% functions to visualize the proces %%%
function plot_line_2(p1,p2)
    hold on
    plot(p1,p2,'-g')
    hold off
end

function plot_data_2(x,y)
    hold on
    plot(x,y,'-c')
    hold off
end

