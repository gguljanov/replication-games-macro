function obj = assign_trueval_varpara(obj)
% Assigns the true parameter values as a property to the object "obj", 
% e.g. for simulating data
%
% Assigns whether a parameter estimated or fixed as a property to the object "obj", 
% e.g. for estimation
% -------------------------------------------------------------------------
% INPUTS
% - obj: PartNonLinearModel object
% -------------------------------------------------------------------------
% OUTPUTS
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

    true_val(params_index.pibar, 1) = .5909; 
    var_para(params_index.pibar, 1) = 0; 

    true_val(params_index.nu, 1) = 0.02; 
    var_para(params_index.nu, 1) = 0; 

    true_val(params_index.g, 1) = 0.13; 
    var_para(params_index.g, 1) = 0;

    true_val(params_index.gammap, 1) = 0.16;
    var_para(params_index.gammap, 1) = 0;

    true_val(params_index.Phi, 1) = 0.92;
    var_para(params_index.Phi, 1) = 0;

    true_val(params_index.rho_phi, 1) = 0.89;
    var_para(params_index.rho_phi, 1) = 0;

    true_val(params_index.rho_pist, 1) = 0.99;
    var_para(params_index.rho_pist, 1) = 1;

    true_val(params_index.sigma_eps, 1) = 0.08;
    var_para(params_index.sigma_eps, 1) = 0;

    true_val(params_index.sigma_u, 1) = 0.35; 
    var_para(params_index.sigma_u, 1) = 0; 

    true_val(params_index.sigma_pist, 1) = 0.1;
    var_para(params_index.sigma_pist, 1) = 1;

    true_val(params_index.pibarF, 1) = 2/4;
    var_para(params_index.pibarF, 1) = 1;

    % Observation errors
    true_val(params_index.sigma_oe1, 1) = 0.29;
    var_para(params_index.sigma_oe1, 1) = 0;

    true_val(params_index.sigma_oe2, 1) = 0.0529;
    var_para(params_index.sigma_oe2, 1) = 0;

    true_val(params_index.sigma_oe3, 1) = 0.0240;
    var_para(params_index.sigma_oe3, 1) = 0; 

    true_val(params_index.sigma_oe4, 1) = 0.0710;
    var_para(params_index.sigma_oe4, 1) = 0;

    true_val(params_index.sigma_oe5, 1) = 0.0489; 
    var_para(params_index.sigma_oe5, 1) = 0;

    true_val(params_index.sigma_oeLT1, 1) = 0.15;
    var_para(params_index.sigma_oeLT1, 1) = 1;

    true_val(params_index.sigma_oeLT2, 1) = 0.15;
    var_para(params_index.sigma_oeLT2, 1) = 1;

    true_val(params_index.sigma_oeF2, 1) = 0.1429;
    var_para(params_index.sigma_oeF2, 1) = 1;

    true_val(params_index.sigma_oeF3, 1) = 0.1210; 
    var_para(params_index.sigma_oeF3, 1) = 1;

    true_val(params_index.sigma_oeF4, 1) = 0.0410;
    var_para(params_index.sigma_oeF4, 1) = 1;

    true_val(params_index.sigma_oeF5, 1) = 0.0489;
    var_para(params_index.sigma_oeF5, 1) = 1;

    true_val(params_index.sigma_oeF6, 1) = 0.0489;
    var_para(params_index.sigma_oeF6, 1) = 1;

    true_val(params_index.sigma_oeF7, 1) = 0.0489;
    var_para(params_index.sigma_oeF7, 1) = 1;

    true_val(params_index.cc, 1) = 0; 
    var_para(params_index.cc, 1) = 1; 

    obj.true_val = true_val;
    obj.var_para = ~var_para;
end
