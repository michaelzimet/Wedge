clear all
load('calc/axon.mat')

%mask = dist<=5;
%dist = dist(mask);
%thresh = thresh(mask);
%thresh_analytic = thresh_analytic(mask);


figure
scatter(dist, thresh, 'b', 'o', 'filled', 'MarkerEdgeAlpha',0.3, 'MarkerFaceAlpha',0.3)
hold on
scatter(dist, thresh_analytic, 'r', 'o', 'filled', 'MarkerEdgeAlpha',0.3, 'MarkerFaceAlpha',0.3)
ax=gca;
ax.FontSize = 12;
xlabel('Axon to Electrode min Distance (mm)', 'FontSize',18)
ylabel('Activation Threshold (mA)', 'FontSize',18)
%xticks()
legend('FEM', 'Analytic', 'FontSize', 12)
%xlim([0.5 5])
saveas(gcf, 'figs/axon.pdf', 'pdf')
