%Script to compile analytic scalers for all contacts and compartments
%from DCC run in parallel

p=1;

load("scalers/scalers_P" + num2str(p)+"_no_encap.mat");
temp=nan(size(scalers));
    
    for c=1:8
        for m=36:36
            load("scalers/analytic_compartments/" + num2str(c) + "/P" + num2str(p) + "_" + num2str(c) + "_" + num2str(m)+ ".mat");
            temp(c, :, m) = scalers_analytic;
        end
    end
clearvars scalers_analytic;
scalers_analytic = temp;

save(['scalers/scalers_analytic_P1_compartments'], "scalers_analytic", '-v7.3'); 

      