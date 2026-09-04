%this script compiles the results from NEURON to save the threshold current
%and distance for each axon, from the FEM and analytic voltage distributions

clear all
load('PlosOne_NEURONcode/data/origin_MIDA1_noScar_axonInfoPlus.mat')

num_axon = max(axonInfo.contact1.nodalPotentials.axonNum);
len_axon = length(axonInfo.contact1.nodalPotentials.axonNum) / num_axon;

coords1 = zeros(3, len_axon, num_axon);
d = zeros(len_axon, num_axon);

for i=1:length(axonInfo.contact1.nodalPotentials.axonNum)
    axon = ceil(i/len_axon);
    node = mod(i, len_axon);
    if node==0
        node = len_axon;
    end
    %distance to center of C1
    coords1(:, node, axon) = [axonInfo.contact1.nodalPotentials.nodalX(i), ...
        axonInfo.contact1.nodalPotentials.nodalY(i), ...
        axonInfo.contact1.nodalPotentials.nodalZ(i)-0.75];

    d(node, axon) = axonInfo.contact1.nodalPotentials.axonElectrodeD(i);
end

r1 = vecnorm(coords1);
dist = zeros(1,num_axon);
dist2 = zeros(1,num_axon);
thresh = zeros(1,num_axon);
thresh_analytic = zeros(1, num_axon);

for a = 1:num_axon
    temp = readtable(['PlosOne_NEURONcode/results/origin_thresh/thresh_c1_' num2str(a) '.txt']);
    thresh(1,a) = temp.Threshold;
    temp_analytic = readtable(['PlosOne_NEURONcode/results/origin_analytic_thresh/thresh_c1_' num2str(a) '.txt']);
    thresh_analytic(1,a) = temp_analytic.Threshold;
    dist(1,a) = min(r1(:, :, a));
    dist2(1,a) = min(d(:, a));
end

mask = dist<10;
dist = dist(mask);
thresh = thresh(mask);
thresh_analytic = thresh_analytic(mask);

save('calc/axon.mat', "dist", "thresh", "thresh_analytic");
