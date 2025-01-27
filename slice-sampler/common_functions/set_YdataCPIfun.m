function [ ...
    vrbs_obs, Y_obs, ...
    Y_data, Y_data_ini, ...
    sample_size, traning_sample, ...
    Estsamplest, Estsamplend ...
    ] = set_YdataCPIfun(LTsurvey)

    % Title: Data and Code for: "Anchored Inflation Expectations"
    % Author: Carlos Carvalho, Stefano Eusepi, Emanuel Moench, Bruce Preston
    % Source: https://doi.org/10.1257/mac.20200080
    % License: This work is licensed under a Creative Commons Attribution 4.0 International (CC BY 4.0) License. (https://creativecommons.org/licenses/by/4.0/)
    %
    % ---------------------------------------------------------
    % MODIFIED BY GAYGYSYZ GULJANOV (gaygysyz.guljan@gmail.com)
    % ---------------------------------------------------------
    %
    % This is distributed in the hope that it will be useful,
    % but WITHOUT ANY WARRANTY; without even the implied warranty of
    % MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    % CC BY 4.0 License for more details.
    % =========================================================================

    % Prepare data
    load("US_Data.mat", "Obs", "Obs_end", "Obs_start", "obsLT", "sampleUS")

    % VarList
    vrbs_obs.infl = 1;
    vrbs_obs.infl1Q_spf = 2;
    vrbs_obs.infl2Q_spf = 3;
    vrbs_obs.infl12Q_liv = 4;
    vrbs_obs.infl12Q_livtrue = 5;

    vrbs_obs.infl3Q_spf = 6;
    vrbs_obs.infl4Q_spf = 7;
    vrbs_obs.infl2Y_bcff = 8;
    vrbs_obs.infl510Y_bcff = 9;
    vrbs_obs.infl110Y_bcff = 10;

    vrbs_obs.n_obsvables = 10;

    fullsamplest = Obs_start;
    fullsamplend = Obs_end;

    fullsample = fullsamplest:1/4:fullsamplend;

    Y_obs = NaN(vrbs_obs.n_obsvables, length(fullsample));

    % Baseline
    Y_obs(vrbs_obs.infl:vrbs_obs.infl12Q_livtrue, :) = Obs(:, vrbs_obs.infl:vrbs_obs.infl12Q_livtrue)';

    if LTsurvey

        %load([dpath, 'LTnanamean']); % contains the 5-10/1-10 forecasts

        Y_obs([vrbs_obs.infl510Y_bcff, vrbs_obs.infl110Y_bcff], :) = obsLT';

    end

    % only CPI
    %Y_obs(vrbs_obs.infl,:) = Obs(:,vrbs_obs.infl)';

    % Compare with Mich
    %Y_obs(1:7,:) = Obs(:,:)';

    % add long term survey (need extended data)

    % Set sample period

    Estsamplest = 1955; traning_sample = 16;

    Estsamplend = 2015.75;

    Estsample = find(fullsample >= Estsamplest & fullsample <= Estsamplend);

    Y_obs = Y_obs(:, Estsample);

    % Select observables used in the estimation: Baseline is only Q1,Q2
    % forecasts

    Y_data = Y_obs;

    % Y_data(vrbs_obs.infl3Q_spf:vrbs_obs.infl510Y_bcei(end),:) = ...
    %     NaN(size(Y_obs(vrbs_obs.infl3Q_spf:vrbs_obs.infl510Y_bcei(end),:)));

    % Setting number of observation shocks
    if LTsurvey
        vrbs_obs.nobs_shocks = 7;
    else
        vrbs_obs.nobs_shocks = 5;
    end

    % Re-set sample size and determine initial conditions

    lags_ini = 3; % lags for initial conditions

    % Set initial conditions

    Y_data_ini = Y_data(:, 1:lags_ini);

    Y_data = Y_data(:, lags_ini + 1:end);

    Y_obs = Y_obs(:, lags_ini + 1:end);

    sample_size = size(Y_data, 2);


