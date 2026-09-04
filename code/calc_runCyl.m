% Script to plot data from FEM model 

path = "/Users/mj217/Documents/MATLAB/";
sphere_rad=10; %mm

for p=1:1
    load("Data_for_Michael/center_of_contact_rows_P" + num2str(p)+".mat");
    C = [C1; C2; C3; C4];
    zhat = C4-C3;
    zhat = zhat/norm(zhat);

    load("at_mesh_nodes/coords_and_potentials_P" + num2str(p)+".mat");
    
    cyl_coords = coords - C4';
    mask = vecnorm(cyl_coords) < sphere_rad;
    potC4 = potentials{8}(mask);
    cyl_coords = cyl_coords(:,mask);
    [cyl] = cylPot(zhat, cyl_coords);
    r4 = vecnorm(cyl_coords);
    
    save('calc/cyl.mat',"zhat", "r4", "cyl_coords", "potC4", "cyl")

    %{
    figure
    scatter3(cyl_coords(1,:), cyl_coords(2,:), cyl_coords(3,:), 1, potC4, 'filled')
    colormap(jet)
    cb = colorbar;
    caxis([0 500])
    
    figure
    scatter3(cyl_coords(1,:), cyl_coords(2,:), cyl_coords(3,:), 1, cyl, 'filled')
    colormap(jet)
    cb = colorbar;
    caxis([0 500])

    figure
    scatter(r4, potC4, 'b', '.')
    hold on
    scatter(r4, cyl, 'r', '.')
    hold on
    scatter(r4, ptSourcePot, 'g', '.')
    hold off
    xlabel('Distance from center of C4 (mm)')
    ylabel('Potential (mV)')
    saveas(gcf, 'figs/mesh_fig.eps', 'epsc');

    %}
end