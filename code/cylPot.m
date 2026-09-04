 %based on analytic equation for symmetric cylindrical sidewall, 
%calculates the electric potential of a DBS electrode
%where the length of the cylinder is in direction zhat
%at cartesian coordinates in coords, which come from FEM mesh
% zhat - length axis of cylinder
% coords - sampling grid (Cartesian)

function [cyl] = cylPot(zhat, coords)

%Inputs
sigma = 0.215/(1e3); %(S/mm)
%delta   = 0.1;           % encapsulation thickness (mm)
R    = 0.65;           % radius (mm)
L    = 0.75;           % half-length (mm)
I = 1.15; %           % current (mA) 
%Re = R + delta;  % Effective radius considering encapsulation thickness

%Helper functions
x2 = @(r,z) (r + R).^2 + z.^2;
x  = @(r,z) sqrt(x2(r,z));
k2 = @(r,z) (4*r.*R) ./ x2(r,z);

%ptvals = nan(1, size(coords,2));
vals = nan(1, size(coords,2));

parfor l = 1:length(coords(1,:))
    c = [coords(1, l), coords(2, l), coords(3,l)];
    
    % Coordinates in cylinder frame
    zloc = dot(c, zhat);
    rloc = norm(c - zloc*zhat);

    %{
     % -------- Piecewise sigma_eff(r) -------
    if rloc <= Re && abs(zloc)<L
        sigma_eff = sigma_e;
    else
        %numerator   = log(rloc/R);
        %denominator = (log(Re/R)/sigma_e) + ...
        %              (log(rloc/Re)/sigma_t);
        sigma_eff = sigma_t; %numerator / denominator;
    end
    %}

    % Integrand
    integrand = @(zp) (1 ./ x(rloc, zloc - zp)) .* ...
                ellipticK(min(k2(rloc, zloc - zp), 0.9999));

    % Integration
    integralVal = integral(integrand, -L, L,'RelTol',1e-8,'AbsTol',1e-10);

    % Potential (mV)
    V = (I / (4*pi^2*sigma*L)) * integralVal;

    if isfinite(V)
    vals(l) = real(V);
    %ptvals(l) = I ./ (4*pi*sigma*vecnorm(c));
    end

end

%ptSourcePot = ptvals;
cyl = vals;

end