%based on analytic equation for symmetric cylindrical sidewall, 
%calculates the electric potential of a DBS electrode
%where the length of the cylinder is in direction zhat
%at cartesian coordinates in coords, which come from FEM mesh
% zhat - length axis of cylinder
% coords - sampling grid (Cartesian)

function [dir] = dirPot(zhat, coords, phi1)

%Inputs
sigma = 0.215/(1e3);   % conductivity (S/mm)
R    = 0.65;           % radius (mm)
L    = 0.75;           % half-length (mm)
I = 1.15;          % current (mA)
%ptSourcePot = I ./ (4*pi*sigma*vecnorm(coords));

% Charged azimuthal sector
phi1 = phi1 - pi;
phi2 = pi/2 + phi1;

%Helper functions
x2 = @(r,z) (r + R).^2 + z.^2;
x  = @(r,z) sqrt(x2(r,z));
k2 = @(r,z) (4*r.*R) ./ x2(r,z);

vals = nan(1, size(coords,2));

parfor l = 1:length(coords(1,:))
    c = [coords(1, l), coords(2, l), coords(3,l)];
    
    % Coordinates in cylinder frame
    zloc = dot(c, zhat);
    rvec = c - zloc*zhat;
    rloc = norm(rvec);
    philoc = mod(atan2(rvec(2), rvec(1)), 2*pi); 

    %if rloc<R && abs(zloc)<L
    %    continue
    %end

    %modify for Eq 2.15
    % Integrand
    integrand = @(zp) (1 ./ x(rloc, zloc - zp)) .* ...
                (ellipticF((philoc - phi1)/2, min(k2(rloc,zloc-zp),0.9999)) ...
                - ellipticF((philoc - phi2)/2, min(k2(rloc,zloc-zp),0.9999)));

    % Integration
    integralVal = integral(integrand, -L, L,'RelTol',1e-8,'AbsTol',1e-10);

    % Potential (mV)
    V = (I / (2*pi^2*sigma*L)) * integralVal;

    if isfinite(V)
    vals(l) = real(V);
    end

end

dir = vals;

end