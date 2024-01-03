function [xfit,yfit] = spline_smooth_downsampling(x,y,g,k,S,type)
%   SPLINE_DOWNSAMPLING find a spline given a 2D curve represented by a
%   (X,Y) vector
%
%   arguments.
%   x,y - Coordinates form an input vector 
%   g   -   grade of the polynomium 
%   k   -   number of knots on the spline spline, also called control points 
%   S   -   numero of points in the otput vector 
%   type -  Different type of used spline and final interpolation. Use 'bspline' 
%           for b-spline or 'smooth' for a smoothing spline
%
%   outputs.
%   xfit,yfit - X,Y resulting spline coordintaes 


    T = linspace(x(1), x(end), length(x));
    T2 = linspace(x(1), x(end), S);
    
    if (type == "bspline")

        T = linspace(x(1), x(end), length(x));
        T2 = linspace(x(1), x(end), S);

        Bsy = spap2(k, g, T, y);
        Bsx = spap2(k, g, T, x);

        xfit = fnval(Bsx, T2);
        yfit = fnval(Bsy, T2);  
        
    end
    
    if (type == "bspline1")
        Bs = cscvn([x;y]);
        data = fnplt(Bs);

        xx = data(1,:);
        yy = data(2,:);

        data_interp = interparc(S, xx, yy,'linear');
        xfit = data_interp(:,1)';
        yfit = data_interp(:,2)'; 
    end

           
    if (type == "smooth1") 

        Bsx = csaps(T, x, k);
        Bsy = csaps(T, y, k);  

        xx = fnval(Bsx, T2);
        yy = fnval(Bsy, T2);      

        data_interp = interparc(S, xx, yy,'linear');
        xfit = data_interp(:,1)';
        yfit = data_interp(:,2)';  
    end
    
    if (type == "smooth2")

        t = linspace(0, arclength(x,y), length(x));        
        Bsx = csaps(t, x, k);
        Bsy = csaps(t, y, k);        

        t2 = linspace(min(t), max(t), S);
        xfit = fnval(Bsx, t2);
        yfit = fnval(Bsy, t2);        
    end

    if (type == "smooth3")

        Bsx = csaps(T, x, k);
        Bsy = csaps(T, y, k);        

        xfit = fnval(Bsx, T2);
        yfit = fnval(Bsy, T2);        
    end
end



