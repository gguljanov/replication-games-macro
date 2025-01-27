classdef PartNonLinearModel
    % Class for Partially Nonlinear Model
    % -------------------------------------------------------------------------
    % INPUTS
    % -------------------------------------------------------------------------
    % OUTPUTS
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
    
    properties(SetAccess = public)
        data; % Data

        % mcmc chain related properties
        bnin; % burn-in as percentage all draws
        lrv; % lenght of estimated parameters
        opt_draws; % Draws from mcmc_optim
        opt_post_at_draws; % Posterior at draws from mcmc_optim
        draws; % mcmc draws
        post_at_draws; % Value of posterior density mcmc draws
        postr_at_mode; % Posterior density at the modes
        alpha_at_rand_draws; % For Chib, Jeliazkov marginal likelihood method
        hm_times_accrate_adj_redone; % No acceptance rate adjustments

        % Mode finding related properties
        mode; % Modes of the posterior
        modeVr; % Inverses of negative hessians at the modes
        lb; % Lower bounds for the parameters
        ub; % Upper bounds for the parameters

        % Random numbers
        Shock;
        Resample_random;
        gain_rand_ini;
        Random_ini;
        VCVini
        
        % Estimation related properties
        vrbs_obs; % Observables
        params_index;
        param_names; % Names of the parameters
        true_val; % True values with which data has been generated, also values of fixed parameters
        var_para; % Boolean vector showing which parameters are being estimated
        estim_time; % Time taken to generate all the chains
        estim_time_each_chain; % Time taken to generate each chain
        solution_counter; % No nonexistence/indeterminacy in model solution
        
        % Prior distribution related properties
        prrMn; % Prior means
        prrVr; % Prior variances
        prrdist; % Prior distributions
        sdist; % Sampling distributions

        sup_class; % Super-class

        estim_opts; % Estimation options
    end


    methods
        function obj = PartNonLinearModel( ...
            vrbs_obs, data, data_name, ...
            Shock, Resample_random, gain_rand_ini, Random_ini, VCVini ...
        )
        % Constructor for PartNonLinearModel
        % -------------------------------------------------------------------------
        % INPUTS
        % -------------------------------------------------------------------------
        % OUTPUTS
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

            add_path()
            
            obj.data = data;

            obj = assign_params_index(obj);
            obj = assign_param_names(obj);
            obj = assign_trueval_varpara(obj);
            obj = assign_priors(obj);
            obj = assign_prrdist(obj);
            
            obj.vrbs_obs = vrbs_obs;

            obj.draws = [];
            obj.bnin = 0.5;
            obj.lrv = sum(obj.var_para);

            % Random numbers
            obj.Shock = Shock;
            obj.Resample_random = Resample_random;
            obj.gain_rand_ini = gain_rand_ini;
            obj.Random_ini = Random_ini;
            obj.VCVini = VCVini;
            
            % Start the chain from prior means
            obj.mode = obj.prrMn(obj.var_para); 
            obj.estim_time = 0;
            obj.estim_time_each_chain = 0;
            obj.solution_counter = 0;

            % Estimation options:
            % Data generation
            obj.estim_opts.nch = 1;
            
            % Markov chain running
            obj.estim_opts.nit = 1e3;
            
            % Saving the results
            obj.estim_opts.varname = "obj";

            obj.estim_opts.data_name = data_name;

            time_now = datetime("now");
            time_now.Format = "dd.MM.yyyy-HH_mm_ss.SSS";

            obj.estim_opts.filename = ( ...
                "res_" + obj.estim_opts.data_name ...
                + sprintf("_%s", time_now) ...
            );

            obj.estim_opts.folderpath = "Estim_res/";

            if ~exist(obj.estim_opts.folderpath, "dir")
                warning( ...
                    "Creating a directory with name %s " ...
                    + "for writing various results \n", ...
                    obj.estim_opts.folderpath ...
                )

                mkdir(obj.estim_opts.folderpath)
            end
        end

        % Assign properties
        obj = assign_params_index(obj)
        
        obj = assign_trueval_varpara(obj)

        obj = assign_priors(obj)
        
        obj = assign_prrdist(obj)

        % Prior
        [prr, prr_vec] = prior(obj, prop2)
                
        % Posterior
        [pst, retcode] = postr_be(obj, prop)
                
        % Estimation        
        obj = gen_mh_draws( ...
            obj, nit, mh_jscale, lower_bound, upper_bound, ... 
            folderpath, out_file_id ...
        )

        draws = get_draws(obj)
        
        [draws_mean, draws_median, draws_prc5, draws_prc95] = get_draws_mean(obj)

        [obj, returncode] = estim_argcheck(obj, input)
        
        [netj, obj] = estim(obj, estim_input)

        % Plot 
        figures_arr = plot_all(mc, plot_type)

        [figures_arr_param] = marginal(obj)

        [figures_arr_param] = means(obj)
    end
    
    methods(Static)
        k_t = f_k( ...
            pi_bar_tm1, k_tm1, sigma_eta_tm1, eta_tm1, ...
            p_gamma, p_Gamma, p_theta_bar, p_g_bar ...
        )
    end
end