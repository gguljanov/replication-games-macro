function [ ...
    draws_mean, draws_mode, draws_prc5, draws_prc95 ...
] = get_draws_mean(obj)

    % Briefly:
    %       - Evaluates the mean of the posterior draws of the object "mc", ...
    %         after discarding the burn-in phase
    % 
    % Structure:
    % 
    % Inputs:
    %       mc: mcmc object
    % 
    % Ouputs:
    %       draws_mean: Mean of the posterior draws after burn-in phase
    % 
    % Literature:
    % 
    % Moreover:
    %
% Evaluates the mean, mode, 5th, and 95th percentile of the posterior draws 
% after discarding the burn-in phase
% -------------------------------------------------------------------------
% INPUTS
% - obj: PartNonLinearModel object
% -------------------------------------------------------------------------
% OUTPUTS
% - draws_mean: mean
% ... 
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

    % See if some posterior values are infinity
    logi = isinf(obj.post_at_draws);

    if any(logi)
        warning("Some of the posterior values are Inf, something is wrong!")
        obj.post_at_draws(logi) = -Inf;
    end

    % Discard the burn-in phase
    draws = get_draws(obj);

    draws = reshape(draws, [obj.lrv, obj.estim_opts.nch * size(draws, 2)]);

    % Get the mean, median, 5/95th percentiles of the draws
    draws_mean = mean(draws, 2);
   
    [~, ind] = maxk(obj.post_at_draws, 1);
    draws_mode = obj.draws(:, ind);
    
    draws_prc5 = prctile(draws, 5, 2);
    draws_prc95 = prctile(draws, 95, 2);
end