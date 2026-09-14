    clear all
    load('calc/at_mesh_nodes.mat')


    cyl_Resid = potC4 - potC4_analytic;
    dir_Resid = potC3a - potC3a_analytic;
    
%% Calculate residual statistics

% Cylindrical
cyl_mean = mean(cyl_Resid);
cyl_median = median(cyl_Resid);
cyl_std  = std(cyl_Resid);
cyl_RMSE = sqrt(mean(cyl_Resid.^2));

% Normalize RMSE by magnitude of FEM potential
cyl_NRMSE = cyl_RMSE / max(potC4) * 100;


% Directional
dir_mean = mean(dir_Resid);
dir_median = median(dir_Resid);
dir_std  = std(dir_Resid);
dir_RMSE = sqrt(mean(dir_Resid.^2));

% Normalize RMSE by magnitude of FEM potential
dir_NRMSE = dir_RMSE / max(potC3a) * 100;


%% Create table

Contact = {'Cylindrical'; 'Directional'};

Mean_mV = [cyl_mean; dir_mean];

Median_mV = [cyl_median; dir_median];

Standard_Deviation_mV = [cyl_std; dir_std];

RMSE_mV = [cyl_RMSE; dir_RMSE];

Normalized_RMSE_percent = [cyl_NRMSE; dir_NRMSE];

T = table(Contact, Mean_mV, Median_mV, Standard_Deviation_mV, ...
    RMSE_mV, Normalized_RMSE_percent);

%% Display table
disp(T)    