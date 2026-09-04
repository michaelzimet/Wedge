% Script to plot data from FEM model 

path = "/Users/mj217/Documents/MATLAB/";
sphere_rad=10; %mm

for p=1:1
    load("Data_for_Michael/center_of_contact_rows_P" + num2str(p)+".mat");
    C = [C1; C2; C3; C4];

    load("at_mesh_nodes/coords_and_potentials_P" + num2str(p)+".mat");
    
    dir_coords = coords - C3';
    mask = vecnorm(dir_coords) < sphere_rad;
    potC3 = potentials{5}(mask);
    dir_coords = dir_coords(:,mask);
    zhat=C4-C3;
    zhat = zhat/norm(zhat);
    dir = dirPot(zhat, dir_coords, 0.8274);
    r3 = vecnorm(dir_coords);
   
    save('calc/dir.mat', "zhat", "dir_coords", "r3", "potC3", "dir")

    %{
    figure
    scatter3(dir_coords(1,:), dir_coords(2,:), dir_coords(3,:), 1, potC3, 'filled')
    colormap(jet)
    cb = colorbar;
    caxis([0 500])
    
    figure
    scatter3(dir_coords(1,:), dir_coords(2,:), dir_coords(3,:), 1, dir, 'filled')
    colormap(jet)
    cb = colorbar;
    caxis([0 500])

    figure
    scatter(r3, potC3, 'b', '.')
    hold on
    scatter(r3, dir, 'r', '.')
    hold on
    scatter(r3, ptSourcePot, 'g', '.')
    hold off
    xlabel('Distance from center of C3 (mm)')
    ylabel('Potential (mV)')   
    saveas(gcf, 'figs/mesh_fig_dir.eps', 'epsc');
    %}

end