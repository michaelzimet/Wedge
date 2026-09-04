% Script to plot data from FEM model 
system('caffeinate -i &');

for p=1:1
    load("Data_for_Michael/center_of_contact_rows_P" + num2str(p)+".mat");
    C = [C1; C2; C3; C4];
    zhat = C4-C3;
    zhat = zhat/norm(zhat);

    load("nrn_locs/nrnlocshet_P" + num2str(p)+".mat");
    nrn_coords = nrnlocs(:, 1:3)';
    
    load("scalers/scalers_P" + num2str(p)+"_soma.mat");

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

    scalers_analytic=zeros(size(scalers));
    scalers_analytic(1, :) = cylPot(zhat, coords1);
    scalers_analytic(2, :) = dirPot(zhat, coords2, 0.8274);
    scalers_analytic(3, :) = dirPot(zhat, coords2, 0.8274 + 2*pi/3);
    scalers_analytic(4, :) = dirPot(zhat, coords2, 0.8274 + 4*pi/3);
    scalers_analytic(5, :) = dirPot(zhat, coords3, 0.8274);
    scalers_analytic(6, :) = dirPot(zhat, coords3, 0.8274 + 2*pi/3);
    scalers_analytic(7, :) = dirPot(zhat, coords3, 0.8274 + 4*pi/3);
    scalers_analytic(8, :) = cylPot(zhat, coords4);

    mask = scalers == 0;
    scalers_analytic(mask) = 0;

    save('calc/scalers_analytic_P1_soma', "scalers_analytic", "r1", "r2", "r3", "r4"); 

end

system('killall caffeinate')