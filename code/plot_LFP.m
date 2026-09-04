dir = '/Users/mj217/Documents/MATLAB/';
subject = 'P1';

load([dir, 'experimental_data/',subject,'_rest.mat']); 

fs_new = 1000; % downsampling at 1000 Hz so we can plot it together with the simulated LFP
for c = 1:8
    data_resamp(c,:) = resample(data(c,:),fs_new,fs);
end

% filter LFP
f_cut = [5, 100]/(fs_new/2); % normalized cutoff frequency
[b,a] = butter(2, f_cut, 'bandpass'); % butterworth bandpass filter

lfp_filt = filtfilt(b, a, double(data_resamp)')'; % apply filter to the downsampled recorded data
L = length(lfp_filt)-500;
lfp_filt = lfp_filt(:,500:L); % delete the first and last 500 ms because it contain filtering artifact

amp_rec = max(max(lfp_filt));
lfp_filt = lfp_filt / amp_rec;
disp(amp_rec)
lfp_filt = lfp_filt';

%time window for recorded LFP
time_rec = 3350:3850;

load("calc/sim_result.mat")

%lfp=100 * lfp;
%lfp_analytic = 100 * lfp_analytic;
amp_sim = max(max(lfp));
lfp =lfp / amp_sim;
%amp_approx = max(max(lfp_analytic));
lfp_analytic = lfp_analytic / amp_sim;
disp(amp_sim)
%disp(amp_approx)

time = 500:1000;
    figure('Units','inches','Position',[1 1 12 6])
    t = tiledlayout(4,7, 'TileSpacing','compact','Padding','none');
    xlabel(t, 'Time (ms)', 'FontSize', 18, 'FontWeight', 'normal')
    ylabel(t,'Monopolar LFP (normalized)', 'Interpreter', 'tex', 'FontSize', 18, 'FontWeight', 'normal')


    % Column titles
    %{
annotation('textbox',[0.18 0.95 0.20 0.04],...
    'String','Experimental Recording',...
    'EdgeColor','none',...
    'HorizontalAlignment','center',...
    'FontSize',18)

annotation('textbox',[0.62 0.95 0.20 0.04],...
    'String','Model Simulation',...
    'EdgeColor','none',...
    'HorizontalAlignment','center',...
    'FontSize',18)
    %nexttile
    %title('Experimental Recording', 'FontSize',16)
    %axis('off')
    %}
    %nexttile
    %title('Model Simulation', 'FontSize',16)
    %axis('off')

    nexttile
    axis('off')

    C4 = nexttile;
    hold(C4, 'on')
    plot(lfp_filt(time_rec, 8), 'Color', [0 0.7 0])
    hold(C4,'off')
    title(C4,'C4', FontSize=12, FontWeight ='normal')
    ylim(C4, [-1 1])
    xlim([0 500])
    yticks([-1, 0, 1])
    xticks([0, 500])
    %C4.YAxis.FontSize=12;
    %C4.XAxis.FontSize=12;

    nexttile
    axis('off')

    nexttile
    axis('off')

    nexttile
    axis('off')
    
    C4 = nexttile;
    hold(C4, 'on')
    plot(lfp(time,8), 'b')
    plot(lfp_analytic(time,8), 'r')
    hold(C4,'off')
    title(C4,'C4', FontSize=12, FontWeight ='normal')
    ylim(C4, [-1 1])
    yticks([-1, 0, 1])
    xlim([0 500])     
    xticks([0, 500])

    leg = legend('FEM', 'Analytic', 'FontSize', 12);
    leg.Position(1) = leg.Position(1) + 0.14;

    nexttile
    axis('off')
   
    C3a = nexttile;
    hold(C3a, 'on')
    plot(lfp_filt(time_rec, 5), 'Color', [0 0.7 0])
    hold(C3a,'off')
    title(C3a,'C3a', FontSize=12, FontWeight ='normal')
    ylim(C3a, [-1 1])
    yticks([-1, 0, 1])
    xlim([0 500])
    xticks([0, 500])
    
    C3b = nexttile;
    hold(C3b, 'on')
    plot(lfp_filt(time_rec, 6), 'Color', [0 0.7 0])
    hold(C3b,'off')
    title(C3b,'C3b', FontSize=12, FontWeight ='normal')
    ylim(C3b, [-1 1])
    yticks([-1, 0, 1])
    xlim([0 500])
    xticks([0, 500])
    
    C3c = nexttile;
    hold(C3c, 'on')
    plot(lfp_filt(time_rec, 7), 'Color', [0 0.7 0])
    hold(C3c,'off')
    title(C3c,'C3c', FontSize=12, FontWeight ='normal')
    ylim(C3c, [-1 1])
    yticks([-1, 0, 1])
    xlim([0 500])
    xticks([0, 500])

    nexttile
    axis('off')

    C3a = nexttile;
    hold(C3a, 'on')
    plot(lfp(time,5), 'b')
    plot(lfp_analytic(time,5), 'r')
    hold(C3a,'off')
    title(C3a,'C3a', FontSize=12, FontWeight ='normal')
    ylim(C3a, [-1 1])
    yticks([-1, 0, 1])
    xlim([0 500])
    xticks([0, 500])
    
    C3b = nexttile;
    hold(C3b, 'on')
    plot(lfp(time,6), 'b')
    plot(lfp_analytic(time,6), 'r')
    hold(C3b,'off')
    title(C3b,'C3b', FontSize=12, FontWeight ='normal')
    ylim(C3b, [-1 1])
    yticks([-1, 0, 1])
    xlim([0 500])
    xticks([0, 500])

    C3c = nexttile;
    hold(C3c, 'on')
    plot(lfp(time,7), 'b')
    plot(lfp_analytic(time,7), 'r')
    hold(C3c,'off')
    title(C3c,'C3c', FontSize=12, FontWeight ='normal')
    ylim(C3c, [-1 1])
    yticks([-1, 0, 1])
    xlim([0 500])
    xticks([0, 500])

    C2a = nexttile;
    hold(C2a, 'on')
    plot(lfp_filt(time_rec, 2), 'Color', [0 0.7 0])
    hold(C2a,'off')
    title(C2a,'C2a', FontSize=12, FontWeight ='normal')
    ylim(C2a, [-1 1])
    yticks([-1, 0, 1])
    xlim([0 500])
    xticks([0, 500])

    C2b = nexttile;
    hold(C2b, 'on')
    plot(lfp_filt(time_rec, 3), 'Color', [0 0.7 0])
    hold(C2b,'off')
    title(C2b,'C2b', FontSize=12, FontWeight ='normal')
    ylim(C2b, [-1 1])
    yticks([-1, 0, 1])
    xlim([0 500])
    xticks([0, 500])
   
    C2c = nexttile;
    hold(C2c, 'on')
    plot(lfp_filt(time_rec, 4), 'Color', [0 0.7 0])
    hold(C2c,'off')
    title(C2c,'C2c', FontSize=12, FontWeight ='normal')
    ylim(C2c, [-1 1])
    yticks([-1, 0, 1])
    xlim([0 500])
    xticks([0, 500])

    nexttile
    axis('off')

    C2a = nexttile;
    hold(C2a, 'on')
    plot(lfp(time,2), 'b')
    plot(lfp_analytic(time,2), 'r')
    hold(C2a,'off')
    title(C2a,'C2a', FontSize=12, FontWeight ='normal')
    ylim(C2a, [-1 1])
    yticks([-1, 0, 1])
    xlim([0 500])
    xticks([0, 500])
    
    C2b = nexttile;
    hold(C2b, 'on')
    plot(lfp(time,3), 'b')
    plot(lfp_analytic(time,3), 'r')
    hold(C2b,'off')
    title(C2b,'C2b', FontSize=12, FontWeight ='normal')
    ylim(C2b, [-1 1])
    yticks([-1, 0, 1])
    xlim([0 500])    
    xticks([0, 500])

    C2c = nexttile;
    hold(C2c, 'on')
    plot(lfp(time,4), 'b')
    plot(lfp_analytic(time,4), 'r')
    hold(C2c,'off')
    title(C2c,'C2c', FontSize=12, FontWeight ='normal')
    ylim(C2c, [-1 1])
    yticks([-1, 0, 1])
    xlim([0 500])
    xticks([0, 500])

    nexttile
    axis('off')

    C1 =nexttile;
    hold(C1, 'on')
    plot(lfp_filt(time_rec, 1), 'Color', [0 0.7 0])
    hold(C1,'off')
    title(C1, 'C1', FontSize=12, FontWeight ='normal')
    ylim(C1, [-1 1])
    yticks([-1, 0, 1])
    xlim([0 500])
    xticks([0, 500])

    nexttile
    axis('off')
    
    nexttile
    axis('off')

    nexttile
    axis('off') 

    C1 =nexttile;
    hold(C1, 'on')
    plot(lfp(time,1), 'b')
    plot(lfp_analytic(time,1), 'r')
    hold(C1,'off')
    title(C1, 'C1', FontSize=12, FontWeight ='normal')
    ylim(C1, [-1 1])
    yticks([-1, 0, 1])
    xlim([0 500])
    xticks([0, 500])


    nexttile
    axis('off')

    saveas(gcf, 'figs/LFP/mono', 'epsc');

%{  
figure
t = tiledlayout(3, 2);
ylabel(t, 'Bipolar LFP (normalized)', 'Interpreter', 'tex', 'FontSize', 18)
xlabel(t, 'Time (ms)', 'Interpreter', 'tex', 'FontSize', 18)

% Column headers
annotation('textbox',[0.15 0.95 0.25 0.03],...
    'String','Experimental Recording',...
    'EdgeColor','none',...
    'HorizontalAlignment','center',...
    'FontSize',18,...
    'FontWeight','bold')

annotation('textbox',[0.60 0.95 0.25 0.03],...
    'String','Model Simulation',...
    'EdgeColor','none',...
    'HorizontalAlignment','center',...
    'FontSize',18,...
    'FontWeight','bold')

nexttile
title('Experimental Recording', 'FontSize',18)
plot(lfp_filt(time_rec, 8) - lfp_filt(time_rec, 1), 'Color', [0 0.7 0])
ylabel('Contact 1 - 4', 'FontSize', 18)
ylim([-1 1])
xlim([0 500])

nexttile
title('Model Simulation', 'FontSize',18)
plot(lfp(time, 8) - lfp(time, 1), 'b')
hold on 
plot(lfp_analytic(time, 8) - lfp_analytic(time, 1), 'r')
%ylabel('Contact 1 - 4', 'FontSize', 18)
ylim([-1 1])
xlim([0 500])

legend('FEM', 'Analytic', 'FontSize', 12)

nexttile
plot(lfp_filt(time_rec, 6) - lfp_filt(time_rec, 2), 'Color', [0 0.7 0])
ylabel('Contact 2a - 3b', 'FontSize', 18)
ylim([-1 1])
xlim([0 500])

nexttile
plot(lfp(time, 6) - lfp(time, 2), 'b')
hold on
plot(lfp_analytic(time, 6) - lfp_analytic(time, 2), 'r')
%ylabel('Contact 2a - 3b', 'FontSize', 18)
ylim([-1 1])
xlim([0 500])

nexttile
plot(lfp_filt(time_rec, 5) - lfp_filt(time_rec, 3), 'Color', [0 0.7 0])
ylabel('Contact 2b - 3a', 'FontSize', 18)
ylim([-1 1])
xlim([0 500])

nexttile
plot(lfp(time, 5) - lfp(time, 3), 'b')
hold on 
plot(lfp_analytic(time, 5) - lfp_analytic(time, 3), 'r')
%ylabel('Contact 2b - 3a', 'FontSize', 18)
ylim([-1 1])
xlim([0 500])

saveas(gcf, 'figs/LFP/bi', 'epsc');
%}

    figure('Units','inches','Position',[1 1 12 12])
    t = tiledlayout(4,7, 'TileSpacing','compact','Padding','none');
    xlabel(t, 'Time (ms)', 'FontSize', 18, 'FontWeight', 'normal')
    ylabel(t,'Monopolar LFP (normalized)', 'Interpreter', 'tex', 'FontSize', 18, 'FontWeight', 'normal')


    % Column titles
    %{
annotation('textbox',[0.18 0.95 0.20 0.04],...
    'String','Experimental Recording',...
    'EdgeColor','none',...
    'HorizontalAlignment','center',...
    'FontSize',18)

annotation('textbox',[0.62 0.95 0.20 0.04],...
    'String','Model Simulation',...
    'EdgeColor','none',...
    'HorizontalAlignment','center',...
    'FontSize',18)
    %nexttile
    %title('Experimental Recording', 'FontSize',16)
    %axis('off')
    %}
    %nexttile
    %title('Model Simulation', 'FontSize',16)
    %axis('off')

    nexttile
    axis('off')

    nexttile
    axis('off')

    nexttile
    axis('off')

    nexttile
    axis('off')

    nexttile
    axis('off')
    
    nexttile
    axis('off')

    nexttile
    axis('off')
   
    C3a = nexttile;
    hold(C3a, 'on')
    plot(lfp_filt(time_rec, 5), 'Color', [0 0.7 0])
    hold(C3a,'off')
    title(C3a,'C3a', FontSize=12, FontWeight ='normal')
    ylim(C3a, [-1 1])
    yticks([-1, 0, 1])
    xlim([0 500])
    xticks([0, 500])
    C3a.XLabel.String = 'Time (ms)';
    C3a.YLabel.String = 'Monopolar LFP (normalized)';
    
    nexttile
    axis('off')
    
    nexttile
    axis('off')

    nexttile
    axis('off')

    C3a = nexttile;
    hold(C3a, 'on')
    plot(lfp(time,5), 'b')
    %plot(lfp_analytic(time,5), 'r')
    hold(C3a,'off')
    title(C3a,'C3a', FontSize=12, FontWeight ='normal')
    ylim(C3a, [-1 1])
    yticks([-1, 0, 1])
    xlim([0 500])
    xticks([0, 500])
    xlabel(t, 'Time (ms)', 'FontSize', 18, 'FontWeight', 'normal')
    ylabel(t,'Monopolar LFP (normalized)', 'Interpreter', 'tex', 'FontSize', 18, 'FontWeight', 'normal')
    C3a.XLabel.String = 'Time (ms)';
    C3a.YLabel.String = 'Monopolar LFP (normalized)';

    saveas(gcf, 'figs/LFP/temp', 'epsc');


    Resid = lfp - lfp_analytic;

    figure('Units','inches','Position',[1 1 8.5 8.5])
    t = tiledlayout(4,3);
    xlabel(t, 'Simulated LFP Residual (normalized)', 'FontSize', 18)
    ylabel(t,'Frequency (\%)', 'Interpreter','latex', 'FontSize',  18) 

    nexttile
    axis('off')

    C4 = nexttile;
    histogram(Resid(time, 8), 'BinWidth', 0.01, 'Normalization', 'percentage')
    xlim([-0.15 0.15])
    ylim([ 0 40])
    title(C4,'C4', 'FontSize', 12, 'FontWeight','normal')
    
    nexttile
    axis('off')
    
    C3a = nexttile;
    histogram(Resid(time, 5), 'BinWidth', 0.01, 'Normalization', 'percentage')
    xlim([-0.15 0.15])
    ylim([ 0 40])
    title(C3a,'C3a', 'FontSize', 12, 'FontWeight','normal')

    C3b = nexttile;
    histogram(Resid(time, 6), 'BinWidth', 0.01, 'Normalization', 'percentage')
    xlim([-0.15 0.15])
    ylim([ 0 40])
    title(C3b,'C3b', 'FontSize', 12, 'FontWeight','normal')

    C3c = nexttile;
    histogram(Resid(time, 7), 'BinWidth', 0.01, 'Normalization', 'percentage')
    xlim([-0.15 0.15])
    ylim([ 0 40])
    title(C3c,'C3c', 'FontSize', 12, 'FontWeight','normal')

    C2a = nexttile;
    histogram(Resid(time, 2), 'BinWidth', 0.01, 'Normalization', 'percentage')
    xlim([-0.15 0.15])
    ylim([ 0 40])
    title(C2a,'C2a', 'FontSize', 12, 'FontWeight','normal')

    C2b = nexttile;
    histogram(Resid(time, 3), 'BinWidth', 0.01, 'Normalization', 'percentage')
    xlim([-0.15 0.15])
    ylim([ 0 40])
    title(C2b,'C2b', 'FontSize', 12, 'FontWeight','normal')

    C2c = nexttile;
    histogram(Resid(time, 4), 'BinWidth', 0.01, 'Normalization', 'percentage')
    xlim([-0.15 0.15])
    ylim([ 0 40])
    title(C2c,'C2c', 'FontSize', 12, 'FontWeight','normal')

    nexttile
    axis('off')

    C1 =nexttile;
    histogram(Resid(time, 1), 'BinWidth', 0.01, 'Normalization', 'percentage')
    xlim([-0.15 0.15])
    ylim([ 0 40])
    title(C1,'C1', 'FontSize', 12, 'FontWeight','normal')


    saveas(gcf, 'figs/LFP/resid.eps', 'epsc');
    