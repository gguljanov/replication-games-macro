function [estim_res_tmp, obj] = estim(obj)
% Runs the estimation process and saves the results in a file
% -------------------------------------------------------------------------
% INPUTS
% - obj: PartNonLinearModel object
% -------------------------------------------------------------------------
% OUTPUTS
% - estim_res_tmp: Estimation results
% - obj: Modified PartNonLinearModel object
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
    
    estim_argcheck(obj);
    
    
    % #####################
    %  MCMC draws
    % #####################
    
    outside_time = tic;
    
    % Generate the chain
    obj = gen_mh_draws(obj);

    % Time of the chain
    obj.estim_time = obj.estim_time + toc(outside_time);
    
    % Mean of the chain
    estim_res_tmp = get_draws_mean(obj);

    % Write the results to a file
    res_filename = make_filepath( ...
        obj.estim_opts.folderpath, ...
        obj.estim_opts.filename + ".mat" ...
    );

    save(res_filename, "obj");
end




