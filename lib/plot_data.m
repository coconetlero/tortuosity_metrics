%%

function plot_data(x,y,color)
% PLOT_DATA: funcion que grafica dos vectores correspondientes a las posiciones (x,y) 
% de un punto

    hold on
%     plot(x,y,'+-','Color',color,'LineWidth', 2.5)    
    plot(x,y,'.-','Color',color,'LineWidth', 1.1)    
    grid on
    axis equal
    hold off
end