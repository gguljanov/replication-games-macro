

function [Hpi,H,mu,R] = getMeasurementEquation(pibar,rho_phi,sigma_oe1,sigma_oe2,sigma_oe3,sigma_oe4,sigma_oe5,sigma_oeLT1,sigma_oeLT2,gammap,vrbs_obs)
% Title: Data and Code for: "Anchored Inflation Expectations"
% Author: Carlos Carvalho, Stefano Eusepi, Emanuel Moench, Bruce Preston
% Source: https://doi.org/10.1257/mac.20200080
% License: This work is licensed under a Creative Commons Attribution 4.0 International (CC BY 4.0) License. (https://creativecommons.org/licenses/by/4.0/)
%
% This is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
% CC BY 4.0 License for more details.
% =========================================================================

%% Observation equation



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%
%%%%% NOTE: this function has to be modified manually if the forecasting model
%%%%% changes!
%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Agents' forecast: pibar, s, pi
OMEGA_c = [ 1                0             0
    0                rho_phi 0
    1-gammap         rho_phi     gammap];


% 2Y-ahead

Kpow2Y58 = 0;

for jj = 5:8
    
    Kpow2Y58 = Kpow2Y58 + OMEGA_c^jj;
    
end

% 15Y-ahead

Kpow15Y120 = 0;


for jj = 1:20
    
    Kpow15Y120 = Kpow15Y120 + OMEGA_c^jj;
    
end


% 510Y-ahead
Kpow510Y2140 = 0;


for jj = 21:40
    
    Kpow510Y2140 = Kpow510Y2140 + OMEGA_c^jj;
    
end


% NOTE: all variables are expressed in annualized terms (mult. by 4)

obscoeff = 4;


% Mean

mu = obscoeff*pibar*ones(vrbs_obs.n_obsvables,1);



% xit

Hm = zeros(vrbs_obs.n_obsvables, 4); % 3 state variables (xi) + pibar = 4


% Simple state vector (xit) ordering
pibt = 1; zt=2; st=3; pit = 4;

sfcts = [pibt st pit];


Hm(vrbs_obs.infl,pit) = 1;


OMc1 = OMEGA_c(3,:);


Hm(vrbs_obs.infl1Q_spf,sfcts) = OMc1;


OMEGA_c2 = OMEGA_c^2;

OMc2 = OMEGA_c2(3,:);

Hm(vrbs_obs.infl2Q_spf,sfcts) = OMc2;


Hm(vrbs_obs.infl12Q_liv, sfcts) = (1/2).*(OMc1 + OMc2);

Hm(vrbs_obs.infl12Q_livtrue, sfcts) = (1/2).*(OMc1 + OMc2);


OMEGA_c3 = OMEGA_c^3;

Hm(vrbs_obs.infl3Q_spf,sfcts) = OMEGA_c3(3,:);


OMEGA_c4 = OMEGA_c^4;

Hm(vrbs_obs.infl4Q_spf,sfcts) = OMEGA_c4(3,:);

Hm(vrbs_obs.infl2Y_bcff,sfcts) = (1/4).*Kpow2Y58(3,:);

Hm(vrbs_obs.infl510Y_bcff,sfcts) = (1/20).*Kpow510Y2140(3,:);

Hm(vrbs_obs.infl110Y_bcff,sfcts) = (1/40).*Kpow15Y120(3,:) + ...
                                  (1/40).*Kpow510Y2140(3,:);


H = obscoeff*Hm(:,2:end)'; % Hamilton notation
Hpi = obscoeff*Hm(:,1);

% Observation errors

% R matrix
Sr = zeros(vrbs_obs.n_obsvables,vrbs_obs.nobs_shocks); %

Sr(vrbs_obs.infl:vrbs_obs.infl12Q_livtrue, 1:5) = diag([sigma_oe1;sigma_oe2;sigma_oe3;sigma_oe4;sigma_oe5]);

Sr(vrbs_obs.infl12Q_liv,5) = sigma_oe5;

Sr(vrbs_obs.infl510Y_bcff,6) = sigma_oeLT1;

Sr(vrbs_obs.infl110Y_bcff,7) = sigma_oeLT2;

Sr = obscoeff*Sr;

R =  Sr*Sr';

