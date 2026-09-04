% Script to plot data
% from results files run in parallel

    %patient
    p=1;

    %compartment
    m = 1;

    load("Data_for_Michael/center_of_contact_rows_P" + num2str(p)+".mat");
    C = [C1; C2; C3; C4];
    zhat = C4-C3;
    zhat = zhat/norm(zhat);

    load("compartment_code/compartment_locs_P1.mat");
    nrn_coords = locrepo;
    load("scalers/scalers_P" + num2str(p)+"_no_encap.mat");
    
    load("calc/scalers_analytic_P1_compartments.mat")

    mask = scalers == 0;
    scalers(mask) = nan;
    scalers_analytic(mask) = nan;

    c1=C(1, :)';
    coords1 = nrn_coords - c1;    
    r1 = vecnorm(coords1);

    c2=C(2, :)';
    coords2 = nrn_coords - c2;
    r2 = vecnorm(coords2);

    c3=C(3, :)';
    coords3 = nrn_coords - c3;
    r3 = vecnorm(coords3);

    c4=C(4, :)';
    coords4 = nrn_coords - c4;
    r4 = vecnorm(coords4);
%}
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
    ylabel(t,'Potential (mV)', 'FontSize', 18) 

    nexttile
    axis('off')

    C4 = nexttile;
    hold(C4, 'on')
    scatter(r4(1,:,m), scalers(8,:,m), 'b', '.')
    scatter(r4(1,:,m), scalers_analytic(8,:,m), 'r', '.')
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
    scatter(r3(1,:,m), scalers(5,:,m), 'b', '.')
    scatter(r3(1,:,m), scalers_analytic(5,:,m), 'r', '.')
    hold(C3a,'off')
    title(C3a,'C3a', 'FontSize', 12, 'FontWeight','normal')
    ylim(C3a, [0 1500])
    xlim(C3a, [0 5])
    xticks([0,1,2,3,4,5])

    C3b = nexttile;
    hold(C3b, 'on')
    scatter(r3(1,:,m), scalers(6,:,m), 'b', '.')
    scatter(r3(1,:,m), scalers_analytic(6,:,m), 'r', '.')
    hold(C3b,'off')
    title(C3b,'C3b', 'FontSize', 12, 'FontWeight','normal')
    ylim(C3b, [0 1500])
    xlim(C3b, [0 5])
    xticks([0,1,2,3,4,5])


    C3c = nexttile;
    hold(C3c, 'on')
    scatter(r3(1,:,m), scalers(7,:,m), 'b', '.')
    scatter(r3(1,:,m), scalers_analytic(7,:,m), 'r', '.')
    hold(C3c,'off')
    title(C3c,'C3c', 'FontSize', 12, 'FontWeight','normal')
    ylim(C3c, [0 1500])
    xlim(C3c, [0 5])
    xticks([0,1,2,3,4,5])

    
    C2a = nexttile;
    hold(C2a, 'on')
    scatter(r2(1,:,m), scalers(2,:,m), 'b', '.')
    scatter(r2(1,:,m), scalers_analytic(2,:,m), 'r', '.')
    hold(C2a,'off')
    title(C2a,'C2a', 'FontSize', 12, 'FontWeight','normal')
    ylim(C2a, [0 1500])
    xlim(C2a, [0 5])
    xticks([0,1,2,3,4,5])


    C2b = nexttile;
    hold(C2b, 'on')
    scatter(r2(1,:,m), scalers(3,:,m), 'b', '.')
    scatter(r2(1,:,m), scalers_analytic(3,:,m), 'r', '.')
    hold(C2b,'off')
    title(C2b,'C2b', 'FontSize', 12, 'FontWeight','normal')
    ylim(C2b, [0 1500])
    xlim(C2b, [0 5])
    xticks([0,1,2,3,4,5])
   
    C2c = nexttile;
    hold(C2c, 'on')
    scatter(r2(1,:,m), scalers(4,:,m), 'b', '.')
    scatter(r2(1,:,m), scalers_analytic(4,:,m), 'r', '.')
    hold(C2c,'off')
    title(C2c,'C2c', 'FontSize', 12, 'FontWeight','normal')
    ylim(C2c, [0 1500])
    xlim(C2c, [0 5])
    xticks([0,1,2,3,4,5])
    
    nexttile
    axis('off')

    C1 =nexttile;
    hold(C1, 'on')
    scatter(C1, r1(1,:,m), scalers(1,:,m), 'b', '.')
    scatter(C1, r1(1,:,m), scalers_analytic(1,:,m), 'r', '.')
    hold(C1,'off')
    title(C1, 'C1', 'FontSize', 12, 'FontWeight','normal')
    ylim(C1, [0 600])
    xlim(C1, [0 5])
    xticks([0,1,2,3,4,5])
    
    saveas(gcf, 'figs/scalers_compartments.pdf', 'pdf');
    %}
    %save(['scalers/compartments/scalers_analytic_P1_compartments',num2str(m)], "scalers_analytic", '-v7.3'); 
%}
