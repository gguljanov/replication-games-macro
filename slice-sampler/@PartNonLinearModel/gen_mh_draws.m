function obj = gen_mh_draws(obj)
% Generates MCMC draws with Slice sampler
% -------------------------------------------------------------------------
% INPUTS
% - obj: PartNonLinearModel object
% -------------------------------------------------------------------------
% OUTPUTS
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
    
    display_results_per = 50;

    if obj.estim_opts.nit < display_results_per
        display_results_per = obj.estim_opts.nit;
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%
    % Old chain or New chain
    %%%%%%%%%%%%%%%%%%%%%%%%%
    nit_old = 0; % no of iterations previously generated
    nit_new = obj.estim_opts.nit; % no of iterations to be generated now
    old_chain = 0;

    if isempty(obj.draws) % No old chain existing
        obj.draws = nan(obj.estim_opts.nch*obj.lrv, obj.estim_opts.nit);

        obj.draws(:, 1) = reshape(obj.mode, [obj.estim_opts.nch*obj.lrv, 1]);

        obj.estim_time_each_chain = zeros(obj.estim_opts.nch, 1);
        
        obj.post_at_draws = nan(obj.estim_opts.nch, obj.estim_opts.nit);
    else % Old chain exists
        nit_old = size(obj.draws, 2);
        
        obj.draws = [obj.draws, nan(obj.lrv*obj.estim_opts.nch, nit_new)];
        
        old_chain = 1;
        
        obj.post_at_draws = [obj.post_at_draws, nan(obj.estim_opts.nch, nit_new)];
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%
    % MCMC algorithm begins
    %%%%%%%%%%%%%%%%%%%%%%%%%
    fprintf('--------\n MCMC generation started \n--------\n')
    
    for jj = 1:obj.estim_opts.nch
        proposal_val = obj.draws( ...
            (jj-1) * obj.lrv + 1 : jj * obj.lrv, ...
            (nit_old-1) * old_chain + 1 ...
        );
                        
        inside_time = tic;
        
        counter = 0;

        
        output_filename = sprintf( ...
            "%s/chain%u_%s.txt", ...
            obj.estim_opts.folderpath, ...
            jj, ...
            obj.estim_opts.filename ...
        );

        output_filename = correct_path(output_filename);


        file_id = fopen(output_filename, "a+");
        
        if file_id == -1
            error("Matlab could not open the file")
        end

        
        
        for ii = nit_old*old_chain+1:nit_old+nit_new
            counter = counter + 1;
            
            sampler_options.rotated = false;
                    
            obj = assign_bounds(obj);

            scalor = [
                0.05000
                0.9
                0.9
                0.9
                0.9
                0.9
                0.05000
                0.05000
                0.05000
                0.05000
                0.05000
                0.05000
                0.0500
                ];
            
            sampler_options.W1 = ( ...
                scalor .* (obj.ub(obj.var_para) - obj.lb(obj.var_para)) ...
            );
            
            params_bounds = [obj.lb(obj.var_para), obj.ub(obj.var_para)];
            
            [proposal_val, postr_fun_val, neval] = slice_sampler( ...
                'postr_be', proposal_val, ...
                 params_bounds, sampler_options, ...
                 obj ...
             );
                        
            % Save the current draw
            obj.draws((jj-1)*obj.lrv+1 : jj*obj.lrv, ii) = proposal_val;
            
            % Save the posterior value to be used for Marginal Likelihood
            obj.post_at_draws(jj, ii) = postr_fun_val;

            
            %%%%%%%%%%%%%%%%%%%%%%%%%
            % Print out the progress
            %%%%%%%%%%%%%%%%%%%%%%%%%
            if counter == display_results_per
                % Counter for the next 'display_results_per' iterations/draws
                counter = 0; 

                % How much percentage of the entire chain got completed?
                perc_completed = (ii / (nit_old + nit_new)) * 100;
                
                % How much time was spent until now?
                est_time_past = obj.estim_time_each_chain(jj) + toc(inside_time); 

                % Appr. how much time is left until the end of chain?
                est_time_left = ( ...
                    est_time_past / perc_completed * (100 - perc_completed) ...
                );

                % Prepare the progress status
                progress_text = sprintf( ...
                    strcat( ...
                        '\n   chain no        : %u', ...
                        '\n   perc. completed : %0.2f', ...
                        '\n   time spent      : %s', ...
                        '\n   est. time left  : %s', ...
                        '\n   number of fevals: %u \n' ...
                    ), ...
                    jj, ...
                    perc_completed, ...
                    dynsec2hms(est_time_past), ...
                    dynsec2hms(est_time_left), ...
                    sum(neval) ...
                );

                % Progress text of parameter values
                progress_text_vals = sprintf( ...
                    " %8.4f    %8.4f    %8.4f \n", ...
                    [ ...
                        obj.true_val(obj.var_para), ...
                        obj.mode, ...
                        mean(obj.draws(:, round(obj.bnin*ii):ii), 2) ...
                    ]' ...
                );

                % Print to a file and the screen
                fprintf( ...
                    file_id, "%s\n%s", progress_text, progress_text_vals ...
                );

                fprintf("%s\n%s", progress_text, progress_text_vals) 
            end
        end

        fclose(file_id);
        
        obj.estim_time_each_chain(jj) = ( ...
            obj.estim_time_each_chain(jj) + toc(inside_time) ...
        );
    end
end