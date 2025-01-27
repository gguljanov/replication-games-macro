function [pst, retcode] = postr_be(prop, obj)
% Evaluates the value of negative log-posterior density 
% at the proposed candidate
% -------------------------------------------------------------------------
% INPUTS
% - prop: Proposed candidate
% - obj: PartNonLinearModel object
% -------------------------------------------------------------------------
% OUTPUTS
% - pst: Log-posterior value
% - retcode: return code
% =========================================================================
% Written by: Gaygysyz Guljanov (2024-2025)
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
    
    % === Evaluate log-prior ===
    prr = prior(obj, prop);

    % === Evaluate the log-likelihood ===
    params = obj.true_val;

    params(obj.var_para) = prop;

    no_particles = 2500;

    gam_eff = 0.75;

    sample_size = size(obj.data, 2);

    trainingSampleLength = 16;

    % Marginalized particle filter
    [liki, retcode] = LIK_Marg_ParticleFilter_Ess( ...
        no_particles, gam_eff, ...
        obj.Shock, ...
        obj.Resample_random, obj.Random_ini, obj.gain_rand_ini, obj.VCVini, ...
        params, obj.params_index, obj.vrbs_obs, ...
        obj.data, trainingSampleLength, sample_size ...
        );
    
    % === Evaluate the negative log-posterior ===
    if prr == -Inf
        pst = Inf;
        
        retcode = 0;
    else
        pst = -1 * (prr + liki);
    end
end