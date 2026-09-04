clear all
load('calc/dir.mat')

%% Extract coordinates
x = dir_coords(1,:);
y = dir_coords(2,:);
z = dir_coords(3,:);
R=0.65;
L=0.75;

%% Create interpolants
F = scatteredInterpolant(x', y', z', potC3', 'natural', 'none');
F2 = scatteredInterpolant(x', y', z', dir', 'natural', 'none');

%% Create orthonormal basis (xhat', yhat', zhat)
% Choose arbitrary vector not parallel to zhat
if abs(dot(zhat,[1;0;0])) < 0.9
    v = [1;0;0];
else
    v = [0;1;0];
end

xhatp = cross(v, zhat);
xhatp = xhatp / norm(xhatp);

yhatp = cross(zhat, xhatp);
yhatp = yhatp / norm(yhatp);

%% -------------------------------------------------
%% 2. Grid resolution
%% -------------------------------------------------
nGrid = 200;

u = linspace(-5, 5, nGrid);
v = linspace(-5, 5, nGrid);
w = linspace(-5, 5, nGrid);

%% -------------------------------------------------
%% 3. AXIAL SLICE (plane ⟂ zhat)
%% -------------------------------------------------
[U,V] = meshgrid(u,v);

% Plane perpendicular to zhat at w = 0
Xa = U*xhatp(1) + V*yhatp(1);
Ya = U*xhatp(2) + V*yhatp(2);
Za = U*xhatp(3) + V*yhatp(3);

Va = F(Xa,Ya,Za);
Va2 = F2(Xa,Ya,Za);

%% -------------------------------------------------
%% 4. CORONAL SLICE (plane containing zhat)
%% -------------------------------------------------
[U2,W] = meshgrid(u,w);

Xc = U2*xhatp(1) + W*zhat(1);
Yc = U2*xhatp(2) + W*zhat(2);
Zc = U2*xhatp(3) + W*zhat(3);

Vc = F(Xc,Yc,Zc);
Vc2 = F2(Xc,Yc,Zc);

%{
%% -------------------------------------------------
%% 5. Plot (single consistent colorbar)
%% -------------------------------------------------

figure

% --- Compute global color limits ---
clim_min = min([Va(:); Vc(:)]);
clim_max = max([Va(:); Vc(:)]);

tlo = tiledlayout(2,2,'TileSpacing','compact','Padding','compact');

%% ---------------- AXIAL ----------------
ax1 = nexttile;
contourf(U, V, Va, 100, 'LineColor','none')
axis equal tight
axis off
title('Axial')
colormap jet
caxis([clim_min clim_max])   % enforce same scale
hold on

theta = linspace(0,2*pi,300);
xcirc = R*cos(theta);
ycirc = R*sin(theta);

fill(xcirc, ycirc, 'k', ...
     'EdgeColor','k', ...
     'LineWidth',1.5)

%% ---------------- CORONAL ----------------
ax2 = nexttile;
contourf(U2, W, Vc, 100, 'LineColor','none')
axis equal tight
axis off
title('Coronal')
colormap jet
caxis([clim_min clim_max])   % same scale
hold on

shaft_color = [0.7 0.7 0.7];
zmin = min(W(:));
zmax = max(W(:));

% Shaft
patch([-R R R -R], ...
      [zmin zmin zmax zmax], ...
      shaft_color, ...
      'EdgeColor','none')

% Active contact
patch([-R R R -R], ...
      [-L -L L L], ...
      'k', ...
      'EdgeColor','none')

%% ---------------- BOTTOM LEFT: AXIAL (Vcyl_a) ----------------
ax3 = nexttile;
contourf(U, V, Va2, 100, 'LineColor','none')
axis equal tight
axis off
%title('Axial (cyl)')
colormap jet
caxis([clim_min clim_max])
hold on

fill(xcirc, ycirc, 'k', 'EdgeColor','k', 'LineWidth',1.5)

%% ---------------- BOTTOM RIGHT: CORONAL (Vcyl_c) ----------------
ax4 = nexttile;
contourf(U2, W, Vc2, 100, 'LineColor','none')
axis equal tight
axis off
%title('Coronal (cyl)')
colormap jet
caxis([clim_min clim_max])
hold on

patch([-R R R -R], [zmin zmin zmax zmax], shaft_color, 'EdgeColor','none')
patch([-R R R -R], [-L -L L L], 'k', 'EdgeColor','none')


%% -------- Single shared colorbar --------
cb = colorbar(ax4,'eastoutside');  % attach to tiledlayout
cb.Label.String = 'Potential (mV)';

%tlo.TileSpacing = 'compact';
%tlo.Padding = 'compact';

set(gcf,'Color','w')
saveas(gcf, 'electrode_fig_dir.eps', 'epsc');
%}


%% ---------------- Transform potentials for log scale ----------------
% Avoid log(0) by adding a small epsilon
%epsilon = 1e-12;
Va_log  = log10(abs(Va));%+epsilon);
Vc_log  = log10(abs(Vc));%+epsilon);
Va2_log = log10(abs(Va2));%+epsilon);
Vc2_log = log10(abs(Vc2));%+epsilon);

% Compute global limits in log scale
clim_min = min([Va_log(:); Vc_log(:); Va2_log(:); Vc2_log(:)]);
clim_max = max([Va_log(:); Vc_log(:); Va2_log(:); Vc2_log(:)]);

%% ---------------- Plot ----------------
figure('Units','inches','Position',[1 1 8.5 11])
tlo = tiledlayout(3,2,'TileSpacing','compact','Padding','none');

theta = linspace(0,2*pi,300);
shaft_color = [0.7 0.7 0.7];
zmin = min(W(:));
zmax = max(W(:));

%% ---------------- AXIAL ----------------
ax1 = nexttile;
contourf(U, V, Va_log, 200, 'LineColor','none')
axis equal tight
axis off
title('Axial', 'FontSize',18, 'FontWeight','normal')
colormap jet
caxis([clim_min clim_max])
hold on
fill(R*cos(theta), R*sin(theta), 'k', 'EdgeColor','k', 'LineWidth',1.5)

%% ---------------- CORONAL ----------------
ax2 = nexttile;
contourf(U2, W, Vc_log, 200, 'LineColor','none')
axis equal tight
axis off
title('Coronal', 'FontSize', 18, 'FontWeight','normal')
colormap jet
caxis([clim_min clim_max])
hold on
patch([-R R R -R], [zmin zmin zmax zmax], shaft_color, 'EdgeColor','none')
patch([-R R R -R], [-L -L L L], 'k', 'EdgeColor','none')

%% ---------------- BOTTOM LEFT: AXIAL (Vcyl_a) ----------------
ax3 = nexttile;
contourf(U, V, Va2_log, 200, 'LineColor','none')
axis equal tight
axis off
colormap jet
caxis([clim_min clim_max])
hold on
fill(R*cos(theta), R*sin(theta), 'k', 'EdgeColor','k', 'LineWidth',1.5)

%% ---------------- BOTTOM RIGHT: CORONAL (Vcyl_c) ----------------
ax4 = nexttile;
contourf(U2, W, Vc2_log, 200, 'LineColor','none')
axis equal tight
axis off
colormap jet
caxis([clim_min clim_max])
hold on
patch([-R R R -R], [zmin zmin zmax zmax], shaft_color, 'EdgeColor','none')
patch([-R R R -R], [-L -L L L], 'k', 'EdgeColor','none')

%% ---------------- Shared colorbar ----------------
cb = colorbar(ax4,'eastoutside');
cb.Label.String = 'Potential (mV, log scale)';
cb.Ticks = linspace(clim_min,clim_max,6);  % optional: fewer ticks

linearVals = 10.^cb.Ticks;
roundedVals = round(linearVals/10)*10;

cb.TickLabels = arrayfun(@(x) sprintf('%.0f', x), roundedVals, ...
                         'UniformOutput', false);

cb = colorbar(ax4,'eastoutside');
cb.Label.String = 'Potential (mV, log scale)';

ticks = [60 70 80 90 100 200 300 400 500 600 700 800 900 1000 1100 1200 1300 1400 1500];

cb.Ticks = log10(ticks);
cb.Limits(1) = cb.Ticks(1);
cb.Limits(2) = cb.Ticks(end);

labels = strings(size(ticks));
labels(:) = "";
labels(1) = "60";
labels(3) = "80";
labels(5) = "100";
labels(6) = "200";
labels(9) = "500";
labels(14) = "1000";
labels(end) = "1500";

cb.TickLabels = labels;
cb.FontSize = 14;

%cb.Ticks = caxis;  % optional: fewer ticks

%linearVals = 10.^cb.Ticks;
%roundedVals = round(linearVals/10)*10;

%cb.TickLabels = arrayfun(@(x) sprintf('%.0f', x), roundedVals, ...
                         %'UniformOutput', false);

cb.Layout.Tile= 'east';
%cb.Position = [0.92 0.35 0.02 0.35];
%cb.Position = [0.95 0.35 0.02 0.65];
%cb.Position(4) = 0.5;

annotation('textbox', [0.07 0.8 0.08 0.05], ...
    'String', 'FEM', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'middle', ...
    'FontSize', 18, ...
    'Rotation', 90);
    %'FontWeight','bold',...
    

annotation('textbox', [0.07 0.47 0.08 0.05], ...
    'String', 'Analytic', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'middle', ...
    'FontSize', 18, ...
    'Rotation', 90);
    %'FontWeight','bold',...


load('calc/at_mesh_nodes.mat')

    
    C3a = nexttile([1 2]);
    hold(C3a, 'on')
    scatter(r3, potC3a, 'b', 'o', 'filled', 'MarkerEdgeAlpha',0.3, 'MarkerFaceAlpha',0.3)
    scatter(r3, potC3a_analytic, 'r', 'o', 'filled', 'MarkerEdgeAlpha',0.3, 'MarkerFaceAlpha',0.3)
    hold(C3a,'off')
    C3a.XAxis.FontSize = 12;
    C3a.YAxis.FontSize = 12;
    xlabel('Distance from center of Contact (mm)', 'FontSize', 18)
    ylabel('Potential (mV)', 'FontSize', 18) 
    %title(C3a,'Directional', 'FontSize', 18)
    ylim(C3a, [0 1500])
    legend('FEM', 'Analytic', 'FontSize', 12)


set(gcf,'Color','w')
saveas(gcf, 'figs/electrode_dir.eps', 'epsc');