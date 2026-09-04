function [] = fn_calc_scalers_analytic_compartments(jobID)
    %Paralellized function to run on cluster
    %Calculates analytic scalers from functions cylPot and dirPot
    %saves results in a .mat file by contact and compartment
    
    %patient
    p=1;

    %contact
    c = ceil(jobID / 365);

    %compartment
    m = mod(jobID, 365); 
    if m==0
        m=365;
    end


    load("Data_for_Michael/center_of_contact_rows_P" + num2str(p)+".mat");
    C = [C1; C2; C3; C4];
    zhat = C4-C3;
    zhat = zhat/norm(zhat);

    load("compartment_code/compartment_locs_P1.mat");
    nrn_coords = locrepo;

    load("scalers/scalers_P" + num2str(p)+"_no_encap.mat");
    scalers_analytic=nan(size(scalers(1, :, 1)));
    mask = scalers(c, :, m)==0;
    
    %center of contact location
    switch c
        case 1
            e=C(1, :)';
        case {2,3,4}
            e=C(2, :)';
        case {5, 6, 7}
             e=C(3, :)';
        case 8
             e=C(4, :)';
    end
    
    %directional angle, found empirically from maximum of scalers
    switch c
        case {1,8}
            phi1=NaN;
        case {2,5}
            phi1=0.8274;
        case {3,6}
            phi1=0.8274 + 2*pi/3;
        case {4,7}
            phi1=0.8274 + 4*pi/3;
    end
    
    %distance from center of contact
    coords = nrn_coords(:,:,m) - e;

    disp(num2str(c));
    %analytic scalers
    switch c
        case {1,8}
            scalers_analytic = cylPot(zhat, coords);
        case {2, 3, 4, 5, 6, 7}
            scalers_analytic = dirPot(zhat, coords, phi1);
    end

    %zeroing out zeros from scalers inside electrode
    scalers_analytic(mask)=0;
   
    save(['scalers/analytic_compartments/', num2str(c), '/P1','_',num2str(c),'_',num2str(m)], "scalers_analytic"); 
    
end