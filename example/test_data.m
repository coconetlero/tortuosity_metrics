clear all
close all



Im = imread("data/16_000_artery_5.tif");
load("data/X.mat")
load("data/Y.mat")

plot_data(X, Y, '#4DBEEE');


%% ----- apply the Smoothing Spline -----
L_c = arclength(X, Y);
S = ceil(length(X) * 0.25);
G = 8 / L_c;

[xfit_f, yfit_f] = spline_smooth_downsampling(X, Y, 4, G, S, 'smooth2');


%% ----- make equidistant points if needed -----
% Sf = length(xfit_f);
% So = length(xfit_o);
%  
% data_interp_f = interparc(Sf, xfit_f, yfit_f,'spline');
% xfit_f = data_interp_f(:,1)';
% yfit_f = data_interp_f(:,2)';

    
   
%% desplegamos el smooth resultante
plot_data(xfit_f, yfit_f, 'r');


%% desplegamos la imagen con los datos sobrepuestos
plot_image_spline([X' Y'], [xfit_f' yfit_f'], Im, 1, "SMOOTH SPLINE")



[DMf, Xescca, Yescca] = distanceMeasure(xfit_f, yfit_f);
[TCf, Xescca, Yescca] = totalCurvature(xfit_f, yfit_f);
[T3f, Xescca, Yescca] = T3(xfit_f, yfit_f);
[T5f, Xescca, Yescca] = T5(xfit_f, yfit_f);
[ICMf, Xescca, Yescca] = InflectionCountMetric(xfit_f, yfit_f);
[TDf, Xescca, Yescca] = tortuosityDensity(xfit_f, yfit_f);
[SOAMf, Xescca, Yescca] = SumOfAngles(xfit_f, yfit_f);
[SCC_f, X_scc_f, Y_scc_f] = sccMeasure(xfit_f, yfit_f, 0);
[ESCC_f, X_escc_f, Y_escc_f] = esccMeasure(xfit_f, yfit_f, 0);










%%
function plot_image_spline(V, V_fit, I, show_o, t)
        
    J = adapthisteq(I,'clipLimit',0.02,'Distribution','rayleigh');
         
    figure()
    imshow(J, 'InitialMagnification', 500)
    title(t)
    hold on 
    if show_o
        plot(V(:,1), V(:,2), '.-', 'Color', 'y', 'LineWidth', 2.5)
    end
    plot(V_fit(:,1), V_fit(:,2), '+-', 'Color', 'g', 'LineWidth', 2.5)    
    hold off
end



