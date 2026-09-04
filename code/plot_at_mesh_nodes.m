    clear all
    load('calc/at_mesh_nodes.mat')

%{
    figure
    scatter3(coords1(1,:), coords1(2,:), coords1(3,:), 1, potC1, 'filled')
    colormap(jet)
    cb = colorbar;
    caxis([0 500])
    
    figure
    scatter3(coords1(1,:), coords1(2,:), coords1(3,:), 1, potC1_analytic, 'filled')
    colormap(jet)
    cb = colorbar;
    caxis([0 500])

    figure
    scatter3(coords2(1,:), coords2(2,:), coords2(3,:), 2, potC2a, 'filled')
    colormap(jet)
    cb = colorbar;
    caxis([0 500])
    
    figure
    scatter3(coords2(1,:), coords2(2,:), coords2(3,:), 1, potC2a_analytic, 'filled')
    colormap(jet)
    cb = colorbar;
    caxis([0 500])

    figure
    scatter3(coords3(1,:), coords3(2,:), coords3(3,:), 2, potC3a, 'filled')
    colormap(jet)
    cb = colorbar;
    caxis([0 500])
    
    figure
    scatter3(coords3(1,:), coords3(2,:), coords3(3,:), 1, potC3a_analytic, 'filled')
    colormap(jet)
    cb = colorbar;
    caxis([0 500])

%}
    t = tiledlayout(2,1);
    xlabel(t, 'Distance from center of Contact (mm)', 'FontSize', 18)
    ylabel(t,'Potential (mV)', 'FontSize', 18) 

    C4 = nexttile;
    hold(C4, 'on')
    scatter(r4, potC4, 'b', 'o', 'filled', 'MarkerEdgeAlpha',0.3, 'MarkerFaceAlpha',0.3)
    scatter(r4, potC4_analytic, 'r' , 'o', 'filled', 'MarkerEdgeAlpha',0.3, 'MarkerFaceAlpha',0.3)
    hold(C4,'off')
    title(C4,'Cylindrical', 'FontSize', 18)
    ylim(C4, [0 600])
  
    
    legend('FEM', 'Analytic', 'FontSize', 12)

    C3a = nexttile;
    hold(C3a, 'on')
    scatter(r3, potC3a, 'b', 'o', 'filled', 'MarkerEdgeAlpha',0.3, 'MarkerFaceAlpha',0.3)
    scatter(r3, potC3a_analytic, 'r', 'o', 'filled', 'MarkerEdgeAlpha',0.3, 'MarkerFaceAlpha',0.3)
    hold(C3a,'off')
    title(C3a,'Directional', 'FontSize', 18)
    ylim(C3a, [0 1500])


    saveas(gcf, 'figs/at_mesh_nodes1.eps', 'epsc');

    figure('Units','inches','Position',[1 1 8.5 8.5])
    t = tiledlayout(4,3);
    xlabel(t, 'Distance from center of Contact (mm)', 'FontSize', 18)
    ylabel(t,'Potential (mV)', 'FontSize',  18) 

    nexttile
    axis('off')

    C4 = nexttile;
    hold(C4, 'on')
    scatter(r4, potC4, 'b', '.')
    scatter(r4, potC4_analytic, 'r', '.')
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
    scatter(r3, potC3a, 'b', '.')
    scatter(r3, potC3a_analytic, 'r', '.')
    hold(C3a,'off')
    title(C3a,'C3a', 'FontSize', 12, 'FontWeight','normal')
    ylim(C3a, [0 1500])
    xlim(C3a, [0 5])
    xticks([0,1,2,3,4,5])


    C3b = nexttile;
    hold(C3b, 'on')
    scatter(r3, potC3b, 'b', '.')
    scatter(r3, potC3b_analytic, 'r', '.')
    hold(C3b,'off')
    title(C3b,'C3b', 'FontSize', 12, 'FontWeight','normal')
    ylim(C3b, [0 1500])
    xlim(C3b, [0 5])
    xticks([0,1,2,3,4,5])


    C3c = nexttile;
    hold(C3c, 'on')
    scatter(r3, potC3c, 'b', '.')
    scatter(r3, potC3c_analytic, 'r', '.')
    hold(C3c,'off')
    title(C3c,'C3c', 'FontSize', 12, 'FontWeight','normal')
    ylim(C3c, [0 1500])
    xlim(C3c, [0 5])
    xticks([0,1,2,3,4,5])

    
    C2a = nexttile;
    hold(C2a, 'on')
    scatter(r2, potC2a, 'b', '.')
    scatter(r2, potC2a_analytic, 'r', '.')
    hold(C2a,'off')
    title(C2a,'C2a', 'FontSize', 12, 'FontWeight','normal')
    ylim(C2a, [0 1500])
    xlim(C2a, [0 5])
    xticks([0,1,2,3,4,5])

    C2b = nexttile;
    hold(C2b, 'on')
    scatter(r2, potC2b, 'b', '.')
    scatter(r2, potC2b_analytic, 'r', '.')
    hold(C2b,'off')
    title(C2b,'C2b', 'FontSize', 12, 'FontWeight','normal')
    ylim(C2b, [0 1500])
    xlim(C2b, [0 5])
    xticks([0,1,2,3,4,5])
   
    C2c = nexttile;
    hold(C2c, 'on')
    scatter(r2, potC2c, 'b', '.')
    scatter(r2, potC2c_analytic, 'r', '.')
    hold(C2c,'off')
    title(C2c,'C2c', 'FontSize', 12, 'FontWeight','normal')
    ylim(C2c, [0 1500])
    xlim(C2c, [0 5])
    xticks([0,1,2,3,4,5])
    
    nexttile
    axis('off')

    C1 =nexttile;
    hold(C1, 'on')
    scatter(C1, r1, potC1, 'b', '.')
    scatter(C1, r1, potC1_analytic, 'r', '.')
    hold(C1,'off')
    title(C1, 'C1', 'FontSize', 12, 'FontWeight','normal')
    ylim(C1, [0 600])
    xlim(C1, [0 5])
    xticks([0,1,2,3,4,5])

    saveas(gcf, 'figs/at_mesh_nodes.pdf', 'pdf');

    figure
    t = tiledlayout(1,1);
    xlabel(t, 'Distance from center of Contact (mm)', 'FontSize', 18)
    ylabel(t,'Potential (mV)', 'FontSize', 18) 

    C4 = nexttile;
    hold(C4, 'on')
    scatter(r4, potC4, 'b', 'o', 'filled', 'MarkerEdgeAlpha',0.3, 'MarkerFaceAlpha',0.3)
    scatter(r4, potC4_analytic, 'r' , 'o', 'filled', 'MarkerEdgeAlpha',0.3, 'MarkerFaceAlpha',0.3)
    hold(C4,'off')
    %title(C4,'Cylindrical', 'FontSize', 18)
    ylim(C4, [0 600])
    
    legend('FEM', 'Analytic', 'FontSize', 12)

    saveas(gcf, 'figs/at_mesh_nodes_cyl.eps', 'epsc');
    
    figure
    t = tiledlayout(1,1);
    xlabel(t, 'Distance from center of Contact (mm)', 'FontSize', 18)
    ylabel(t,'Potential (mV)', 'FontSize', 18) 

    C3a = nexttile;
    hold(C3a, 'on')
    scatter(r3, potC3a, 'b', 'o', 'filled', 'MarkerEdgeAlpha',0.3, 'MarkerFaceAlpha',0.3)
    scatter(r3, potC3a_analytic, 'r', 'o', 'filled', 'MarkerEdgeAlpha',0.3, 'MarkerFaceAlpha',0.3)
    hold(C3a,'off')
    %title(C3a,'Directional', 'FontSize', 18)
    ylim(C3a, [0 1500])

    legend('FEM', 'Analytic', 'FontSize', 12)

    saveas(gcf, 'figs/at_mesh_nodes_dir.eps', 'epsc');

    figure
    t = tiledlayout(2,1);
    xlabel(t, 'Potential Residual (mV)', 'FontSize', 18)
    ylabel(t,'Frequency (\%)','Interpreter', 'Latex', 'FontSize', 18) 

    C4 = nexttile;
    hold(C4, 'on')
    histogram(potC4 - potC4_analytic, 'Normalization', 'percentage', 'BinWidth',2.5)
    hold(C4,'off')
    title(C4,'Cylindrical', 'FontSize', 18)
    xlim(C4, [-100,100])
    %ylim(C4, [0 600])
    
    C3a = nexttile;
    hold(C3a, 'on')
    histogram(potC3a - potC3a_analytic, 'Normalization', 'percentage', 'BinWidth',5)
    hold(C3a,'off')
    title(C3a,'Directional', 'FontSize', 18)
    xlim(C3a, [-200,200])
    %ylim(C3a, [0 1500])

    saveas(gcf, 'figs/Resid_at_mesh_nodes.pdf', 'pdf');
