function obj = assign_prrdist(obj)
% Assigns the prior shapes as a property to the object "obj"
% -------------------------------------------------------------------------
% INPUTS
% - obj: PartNonLinearModel object
% -------------------------------------------------------------------------
% OUTPUTS
% =========================================================================
% Written by: Gaygysyz Guljanov (2024-2025)
% 
% Heavily based on "definePriors.m" 
% from "Carvalho, Carlos , Eusepi, Stefano, Moench, Emanuel, and Preston, Bruce. 
% Data and Code for: “Anchored Inflation Expectations.” Nashville, 
% TN: American Economic Association [publisher], 2023. Ann Arbor, 
% MI: Inter-university Consortium for Political and Social Research [distributor], 2023-01-23. 
% https://doi.org/10.3886/E147021V1"
%
% This is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
% GNU General Public License for more details.
% -------------------------------------------------------------------------
% This file is part of the replication files for the replication paper 
% "A Replication of Anchored Inflation Expectations" (2024)
% by Boris Blagov, Gaygysyz Guljanov, and Aicha Kharazi
% =========================================================================   
   
    ind = obj.params_index;

    % Assign prior distribution shapes,
    % e.g. these are parameters from beta distribution
    prrdist.beta_param = [ind.gammap, ind.Phi, ind.rho_phi];
    
    prrdist.gamma_param = [ind.nu, ind.g]; 
    
    prrdist.normal_param = [ind.pibar, ind.pibarF];
    
    prrdist.invgamma_param = [ ...
        ind.sigma_eps, ind.sigma_u, ind.sigma_pist, ...
        ind.sigma_oe1, ind.sigma_oe2, ind.sigma_oe3, ...
        ind.sigma_oe4, ind.sigma_oe5, ...
        ind.sigma_oeLT1, ind.sigma_oeLT2, ...
        ind.sigma_oeF2, ind.sigma_oeF3, ind.sigma_oeF4, ...
        ind.sigma_oeF5, ind.sigma_oeF6, ind.sigma_oeF7 ...
        ]; 
    
    prrdist.fixed_param = [];

    obj.prrdist = prrdist;
end