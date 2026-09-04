%based on data in axonInfo,
%this script calculates the analytic potential at each node of each axon
%and writes the results into .txt files, 
%as inputs to NEURON to calculate the threshold activation current for each axon

system('caffeinate -i &');

clear all
load('PlosOne_NEURONcode/data/origin_MIDA1_noScar_axonInfoPlus.mat')

coords1 = [axonInfo.contact1.nodalPotentials.nodalX, ...
        axonInfo.contact1.nodalPotentials.nodalY, ...
        axonInfo.contact1.nodalPotentials.nodalZ-0.75]';
r1 = vecnorm(coords1);
d = axonInfo.contact1.nodalPotentials.axonElectrodeD;
potC1 = axonInfo.contact1.nodalPotentials.phi;
zhat = [0 0 1];
cyl1 = cylPot(zhat, coords1)' * -1e-3;


num_axon = max(axonInfo.contact1.nodalPotentials.axonNum);
len_axon = length(axonInfo.contact1.nodalPotentials.axonNum) / num_axon;


for a = 1:num_axon    
    cyl_axon = cyl1((a-1)*len_axon +1:a*len_axon);    
    writematrix(cyl_axon, ['PlosOne_NEURONcode/data/origin_analytic/c1_' num2str(a)]);
end

figure
scatter(r1, potC1, 'b','o', 'filled', 'MarkerEdgeAlpha',0.3, 'MarkerFaceAlpha',0.3)
hold on
scatter(r1, cyl1, 'r','o', 'filled', 'MarkerEdgeAlpha',0.3, 'MarkerFaceAlpha',0.3)

system('killall caffeinate')