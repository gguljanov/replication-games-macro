%%
% This file runs the estimation process, either starting a new MCMC chain
% or continuing the old one (uncomment the respective lines)
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
%

%% New chain
clear; clc;

add_path()

% Prepare the data
LTsurvey = 0;

[ ...
        vrbs_obs, Y_obs, ...
        Y_data, Y_data_ini, ...
        sample_size, traning_sample, ...
        Estsamplest, Estsamplend ...
    ] = set_YdataCPIfun(LTsurvey);


% Load the random numbers
load( ...
    "RandomStuff2500.mat", ...
    "Shock", "Resample_random", "gain_rand_ini", "Random_ini" ...
)

VCV_ini = (1/10) * eye(3);

% Make the model object
obj = PartNonLinearModel( ...
    vrbs_obs, Y_data, "us_origdata", ...
    Shock, Resample_random, gain_rand_ini, Random_ini, VCV_ini ...
);

obj.estim_opts.nit = 1200;

[res_tmp, obj] = estim(obj);

% test = load("test_postr_be.mat");
% 
% n_test = 11;
% post_vals = nan(1, n_test);
% 
% tic
% for ii = 1:n_test
%     post_vals(ii) = postr_be(test.X_draws(:, ii), obj);
% end
% toc
% 
% disp(sum(abs(test.Logpost_draws + post_vals)))
% 
% sound(sin(0:300))
% 
% 
% %% Continue old chain
% clear; clc;
% 
% load("Estim_res/res_us_origdata_02.10.2023-19_56_54.247.mat", "obj")
% 
% obj.estim_opts.nit = 1000;
% 
% obj = estim(obj);
