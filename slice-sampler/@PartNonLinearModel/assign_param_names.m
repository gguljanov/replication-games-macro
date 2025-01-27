function obj = assign_param_names(obj)
% Assigns the parameter names as a property to the object "obj"
% -------------------------------------------------------------------------
% INPUTS
% - obj: PartNonLinearModel object
% -------------------------------------------------------------------------
% OUTPUTS 
% =========================================================================
% Written by: Gaygysyz Guljanov (2024-2025)
% 
% Heavily based on "CreateTable1.m" 
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

    param_names = [
        "$\pi^*$";
        "$\bar{\theta}$";
        "$\bar{g}$";
        "$\gamma$";
        "$\Gamma$";
        "$\rho$";
        "$\sigma_{\tilde{\epsilon}}$";
        "$\sigma_{\tilde{\mu}}$";
        "$\sigma_{o, 1}$";
        "$\sigma_{o, 2}$";
        "$\sigma_{o, 3}$";
        "$\sigma_{o, 4}$";
        "$\sigma_{o, 5}$"
    ];

    obj.param_names = param_names;
end