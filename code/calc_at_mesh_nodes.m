% Script to plot data from FEM model 

system('caffeinate -i &');
path = "/Users/mj217/Documents/MATLAB/";
sphere_rad=5; %mm
p=1;

    load("Data_for_Michael/center_of_contact_rows_P" + num2str(p)+".mat");
    C = [C1; C2; C3; C4];
    zhat = C4-C3;
    zhat = zhat/norm(zhat);

    load("at_mesh_nodes/coords_and_potentials_P" + num2str(p)+".mat");
    
    c1=C(1, :)';
    coords1 = coords - c1;
    mask = vecnorm(coords1)<sphere_rad;
    coords1 = coords1(:,mask);
    potC1 = potentials{1}(mask);
    potC1_analytic = cylPot(zhat, coords1);
    r1 = vecnorm(coords1);
    
    c2=C(2, :)';
    coords2 = coords - c2;
    mask = vecnorm(coords2)<sphere_rad;
    coords2 = coords2(:, mask);
    potC2a = potentials{2}(mask);
    potC2b = potentials{3}(mask);
    potC2c = potentials{4}(mask);
    potC2a_analytic = dirPot(zhat, coords2, 0.8274); %value from finding phi for max value in potC2a
    potC2b_analytic = dirPot(zhat, coords2, 0.8274 + 2*pi/3);
    potC2c_analytic = dirPot(zhat, coords2, 0.8274 + 4*pi/3);
    r2=vecnorm(coords2);
    
    c3=C(3, :)';
    coords3 = coords - c3;
    mask = vecnorm(coords3)<sphere_rad;
    coords3 = coords3(:, mask);
    potC3a = potentials{5}(mask);
    potC3b = potentials{6}(mask);
    potC3c = potentials{7}(mask);
    potC3a_analytic = dirPot(zhat, coords3, 0.8274); %agrees with contact 2
    potC3b_analytic = dirPot(zhat, coords3, 0.8274 + 2*pi/3);
    potC3c_analytic = dirPot(zhat, coords3, 0.8274 + 4*pi/3);
    r3=vecnorm(coords3);

    c4=C(4, :)';
    coords4 = coords - c4;
    mask = vecnorm(coords4)<sphere_rad;
    coords4 = coords4(:,mask);
    potC4 = potentials{8}(mask);
    potC4_analytic = cylPot(zhat, coords4);
    r4 = vecnorm(coords4);
   
    save('calc/at_mesh_nodes.mat', "r1", "r2", "r3", "r4","potC1", "potC2a", "potC2b", "potC2c", "potC3a", "potC3b", "potC3c", "potC4", "potC1_analytic", "potC2a_analytic", "potC2b_analytic", "potC2c_analytic", "potC3a_analytic", "potC3b_analytic", "potC3c_analytic", "potC4_analytic")

     
system('killall caffeinate')