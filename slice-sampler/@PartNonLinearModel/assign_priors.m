function obj = assign_priors(obj)
% Assigns the prior means and variances as properties to the object "obj"
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

    params_index = obj.params_index;

    obj.prrMn(params_index.pibar, 1) = 2.25/4;
    obj.prrMn(params_index.pibarF, 1) = 2.25/4;
    obj.prrMn(params_index.nu, 1) = 0.050;
    obj.prrMn(params_index.g, 1) = 0.100;
    obj.prrMn(params_index.gammap, 1) = 0.5;
    obj.prrMn(params_index.Phi, 1) = 0.5;
    obj.prrMn(params_index.rho_phi, 1) = 0.5;
    obj.prrMn(params_index.sigma_eps, 1) = 0.1;
    obj.prrMn(params_index.sigma_u, 1) = 0.1;
    obj.prrMn(params_index.sigma_pist, 1) = 0.1;
    obj.prrMn(params_index.sigma_oe1, 1) = 0.1;
    obj.prrMn(params_index.sigma_oe2, 1) = 0.1;
    obj.prrMn(params_index.sigma_oe3, 1) = 0.1;
    obj.prrMn(params_index.sigma_oe4, 1) = 0.1;
    obj.prrMn(params_index.sigma_oe5, 1) = 0.1;
    obj.prrMn(params_index.sigma_oeLT1, 1) = 0.1;
    obj.prrMn(params_index.sigma_oeLT2, 1) = 0.1;
    obj.prrMn(params_index.sigma_oeF2, 1) = 0.1;
    obj.prrMn(params_index.sigma_oeF3, 1) = 0.1;
    obj.prrMn(params_index.sigma_oeF4, 1) = 0.1;
    obj.prrMn(params_index.sigma_oeF5, 1) = 0.1;
    obj.prrMn(params_index.sigma_oeF6, 1) = 0.1;
    obj.prrMn(params_index.sigma_oeF7, 1) = 0.1;

    obj.prrVr(params_index.pibar, 1) = 0.1^2;
    obj.prrVr(params_index.pibarF, 1) = 0.1^2;
    obj.prrVr(params_index.nu, 1) = 0.040^2;
    obj.prrVr(params_index.g, 1) = 0.090^2;
    obj.prrVr(params_index.gammap, 1) = 0.070;
    obj.prrVr(params_index.Phi, 1) = 0.070;
    obj.prrVr(params_index.rho_phi, 1) = 0.20^2;
    obj.prrVr(params_index.sigma_eps, 1) = 2.000^2;
    obj.prrVr(params_index.sigma_u, 1) = 1;
    obj.prrVr(params_index.sigma_pist, 1) = 1;
    obj.prrVr(params_index.sigma_oe1, 1) = 1;
    obj.prrVr(params_index.sigma_oe2, 1) = 1;
    obj.prrVr(params_index.sigma_oe3, 1) = 1;
    obj.prrVr(params_index.sigma_oe4, 1) = 1;
    obj.prrVr(params_index.sigma_oe5, 1) = 1;
    obj.prrVr(params_index.sigma_oeLT1, 1) = 1;
    obj.prrVr(params_index.sigma_oeLT2, 1) = 1;
    obj.prrVr(params_index.sigma_oeF2, 1) = 1;
    obj.prrVr(params_index.sigma_oeF3, 1) = 1;
    obj.prrVr(params_index.sigma_oeF4, 1) = 1;
    obj.prrVr(params_index.sigma_oeF5, 1) = 1;
    obj.prrVr(params_index.sigma_oeF6, 1) = 1;
    obj.prrVr(params_index.sigma_oeF7, 1) = 1;
end
