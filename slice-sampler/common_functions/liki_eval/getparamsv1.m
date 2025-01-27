function [pibar, nu, g, gammap, Tpi, PhiT,rho_phi, sigma_eps,sigma_u,STDfeM,sigma_oe1,sigma_oe2,sigma_oe3,sigma_oe4,sigma_oe5,sigma_oeLT1,sigma_oeLT2] = getparamsv1(params, params_index)
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

% Function assigns model parameter values as a function of the vector
% params. Each parameters is determined by the location index params_index

% NOTE: we have tranformed some of the params to match SmetsWouters priors
pibar = params(params_index.pibar) ;
nu = params(params_index.nu) ;
g = params(params_index.g) ;
gammap = params(params_index.gammap) ;
% PhiT = params(params_index.PhiT) ;
% Tpi =  1 - (1 - PhiT)/(g * (1-gammap));

Tpi = params(params_index.Phi) ;
PhiT = abs(g*(1-gammap)*(Tpi-1)+1) ;

rho_phi = params(params_index.rho_phi) ;

sigma_eps = params(params_index.sigma_eps) ;
sigma_u = params(params_index.sigma_u) ;

sigma_oe1 = params(params_index.sigma_oe1) ;
sigma_oe2 = params(params_index.sigma_oe2) ;
sigma_oe3 = params(params_index.sigma_oe3) ;
sigma_oe4 = params(params_index.sigma_oe4) ;
sigma_oe5 = params(params_index.sigma_oe5) ;
sigma_oeLT1 = params(params_index.sigma_oeLT1) ;
sigma_oeLT2 = params(params_index.sigma_oeLT2) ;

STDfeM = sigma_eps + sigma_u;
