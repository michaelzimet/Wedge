% Script to plot data from FEM model 

for p=1:1
   
    load("scalers/scalers_P" + num2str(p)+"_soma.mat");
    load("calc/scalers_analytic_P1_soma.mat");
    
    mask = scalers==0;
    scalers(mask) = nan;
    scalers_analytic(mask) = nan;


    %{
    figure
    scatter3(coords(1,:), coords(2,:), coords(3,:), 1, scalers(1, :), 'filled')
    colormap(jet)
    cb = colorbar;
    caxis([0 150])
    
    figure
    scatter3(coords(1,:), coords(2,:), coords(3,:), 1, scalers_analytic(1, :), 'filled')
    colormap(jet)
    cb = colorbar;
    caxis([0 150])
    %}    
    
    figure('Units','inches','Position',[1 1 8.5 8.5])
    t = tiledlayout(4,3);
    xlabel(t, 'Distance from center of Contact (mm)', 'FontSize', 18)
    ylabel(t,'Potential (mV)', 'FontSize',  18) 

    nexttile
    axis('off')

    C4 = nexttile;
    hold(C4, 'on')
    scatter(r4, scalers(8,:), 'b', '.')
    scatter(r4, scalers_analytic(8,:), 'r', '.')
    hold(C4,'off')
    title(C4,'C4', 'FontSize', 12, 'FontWeight','normal')
    ylim(C4, [0 600])
    xlim(C4, [0 5])
    xticks([0,1,2,3,4,5])

    l = legend('FEM', 'Analytic', 'FontSize', 12);
    l.Position(1) = l.Position(1) + 0.25;

    nexttile
    axis('off')

    
    C3a = nexttile;
    hold(C3a, 'on')
    scatter(r3, scalers(5,:), 'b', '.')
    scatter(r3, scalers_analytic(5,:), 'r', '.')
    hold(C3a,'off')
    title(C3a,'C3a', 'FontSize', 12, 'FontWeight','normal')
    ylim(C3a, [0 1500])
    xlim(C3a, [0 5])
    xticks([0,1,2,3,4,5])


    C3b = nexttile;
    hold(C3b, 'on')
    scatter(r3, scalers(6,:), 'b', '.')
    scatter(r3, scalers_analytic(6,:), 'r', '.')
    hold(C3b,'off')
    title(C3b,'C3b', 'FontSize', 12, 'FontWeight','normal')
    ylim(C3b, [0 1500])
    xlim(C3b, [0 5])
    xticks([0,1,2,3,4,5])


    C3c = nexttile;
    hold(C3c, 'on')
    scatter(r3, scalers(7,:), 'b', '.')
    scatter(r3, scalers_analytic(7,:), 'r', '.')
    hold(C3c,'off')
    title(C3c,'C3c', 'FontSize', 12, 'FontWeight','normal')
    ylim(C3c, [0 1500])
    xlim(C3c, [0 5])
    xticks([0,1,2,3,4,5])

    
    C2a = nexttile;
    hold(C2a, 'on')
    scatter(r2, scalers(2,:), 'b', '.')
    scatter(r2, scalers_analytic(2,:), 'r', '.')
    hold(C2a,'off')
    title(C2a,'C2a', 'FontSize', 12, 'FontWeight','normal')
    ylim(C2a, [0 1500])
    xlim(C2a, [0 5])
    xticks([0,1,2,3,4,5])

    C2b = nexttile;
    hold(C2b, 'on')
    scatter(r2, scalers(3,:), 'b', '.')
    scatter(r2, scalers_analytic(3,:), 'r', '.')
    hold(C2b,'off')
    title(C2b,'C2b', 'FontSize', 12, 'FontWeight','normal')
    ylim(C2b, [0 1500])
    xlim(C2b, [0 5])
    xticks([0,1,2,3,4,5])
   
    C2c = nexttile;
    hold(C2c, 'on')
    scatter(r2, scalers(4,:), 'b', '.')
    scatter(r2, scalers_analytic(4,:), 'r', '.')
    hold(C2c,'off')
    title(C2c,'C2c', 'FontSize', 12, 'FontWeight','normal')
    ylim(C2c, [0 1500])
    xlim(C2c, [0 5])
    xticks([0,1,2,3,4,5])
    
    nexttile
    axis('off')

    C1 =nexttile;
    hold(C1, 'on')
    scatter(C1, r1, scalers(1,:), 'b', '.')
    scatter(C1, r1, scalers_analytic(1,:), 'r', '.')
    hold(C1,'off')
    title(C1, 'C1', 'FontSize', 12, 'FontWeight','normal')
    ylim(C1, [0 600])
    xlim(C1, [0 5])
    xticks([0,1,2,3,4,5])

    saveas(gcf, 'figs/scalers_soma.pdf', 'pdf');

end
