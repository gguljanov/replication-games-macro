function obj = assign_params_index(obj)
% Assigns the parameter indices as a property to the object "obj"
% -------------------------------------------------------------------------
% INPUTS
% - obj: PartNonLinearModel object
% -------------------------------------------------------------------------
% OUTPUTS
% Assigns parameter indices as param_index property to the obj
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

    params_index.pibar = 1; 
    
    params_index.nu = 2; 
    
    params_index.g = 3; 
    
    params_index.gammap = 4;
    
    params_index.Phi = 5;
    
    params_index.rho_phi = 6;
    
    params_index.rho_pist = 7;
    
    params_index.sigma_eps = 8;
    
    params_index.sigma_u = 9;
    
    params_index.sigma_pist = 10;
    
    params_index.pibarF = 11;
    
    st_params = 11;

    % Observation errors
    params_index.sigma_oe1 = st_params + 1;
    params_index.sigma_oe2 = st_params + 2;
    params_index.sigma_oe3 = st_params + 3;
    params_index.sigma_oe4 = st_params + 4; 
    params_index.sigma_oe5 = st_params + 5;
    
    params_index.sigma_oeLT1 = st_params + 6;
    params_index.sigma_oeLT2 = st_params + 7;
    
    params_index.sigma_oeF2 = st_params + 8;
    params_index.sigma_oeF3 = st_params + 9;
    params_index.sigma_oeF4 = st_params + 10;
    params_index.sigma_oeF5 = st_params + 11;
    params_index.sigma_oeF6 = st_params + 12;
    params_index.sigma_oeF7 = st_params + 13;
    
    params_index.cc = st_params + 14;

    obj.params_index = params_index;
end