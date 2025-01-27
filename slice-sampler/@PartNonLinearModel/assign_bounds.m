function obj = assign_bounds(obj)
% Assigns the bounds for all the parameters
% -------------------------------------------------------------------------
% INPUTS
% - obj: PartNonLinearModel object
% -------------------------------------------------------------------------
% OUTPUTS
% - obj: Modified PartNonLinearModel object
% =========================================================================
% Written by: Gaygysyz Guljanov (2024-2025)
% 
% Heavily based on "setParamsv1.m" 
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

    % Bounds (for MH algorithm)
    bounds(params_index.pibar, :) = [1E-5 +50];

    bounds(params_index.pibarF, :) = [1E-5 +50];

    bounds(params_index.nu, :) = [1E-5 0.999];

    bounds(params_index.g, :) = [1E-5 0.999];

    bounds(params_index.gammap, :) = [1E-5 0.999];

    bounds(params_index.Phi, :) = [1E-5 0.996];

    bounds(params_index.rho_phi, :) = [1E-5 0.999];

    bounds(params_index.rho_pist, :) = [1E-5 0.999];

    bounds(params_index.sigma_eps, :) = [1E-5 50];

    bounds(params_index.sigma_u, :) = [1E-5 50];

    bounds(params_index.sigma_pist, :) = [1E-5 50];

    bounds(params_index.sigma_oe1, :) = [0.0001 50];

    bounds(params_index.sigma_oe2, :) = [0.0001 50];

    bounds(params_index.sigma_oe3, :) = [0.0001 50];

    bounds(params_index.sigma_oe4, :) = [0.0001 50];

    bounds(params_index.sigma_oe5, :) = [0.0001 50];

    bounds(params_index.sigma_oeLT1, :) = [0.0001 50];

    bounds(params_index.sigma_oeLT2, :) = [0.0001 50];

    bounds(params_index.sigma_oeF2, :) = [0.0001 50];

    bounds(params_index.sigma_oeF3, :) = [0.0001 50];

    bounds(params_index.sigma_oeF4, :) = [0.0001 50];

    bounds(params_index.sigma_oeF5, :) = [0.0001 50];

    bounds(params_index.sigma_oeF6, :) = [0.0001 50];

    bounds(params_index.sigma_oeF7, :) = [0.0001 50];

    % Set the object properties
    obj.lb = bounds(:, 1);
    obj.ub = bounds(:, 2);
end