function [Lik, flag] = LIK_Marg_ParticleFilter_Ess( ...
    N, gam_eff, Shock, Resample_random, Random_ini, ...
    gain_rand_ini, VCVini, params, params_index, vrbs_obs, ...
    Y_data, trainingSampleLength, sampleSize ...
    )
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

    flag = 0;

    % Computes Marginalized Particle Filter
    % Uses notes: "ParticleFiltervv4"

    %tic

    [pibar, nu, g, gammap, Tpi, PhiT, rho_phi, sigma_eps, sigma_u, STDfeM, sigma_oe1, sigma_oe2, sigma_oe3, sigma_oe4, sigma_oe5, sigma_oeLT1, sigma_oeLT2] = getparamsv1(params, params_index);

    if PhiT > 0.995
        % Lik = -10e20; flag = 1; disp('damn!');disp(abs(detOMt)); return
        Lik = -10e20; flag = 1; return

    end

    [Hpi, H, mu, R] = getMeasurementEquation(pibar, rho_phi, sigma_oe1, sigma_oe2, sigma_oe3, sigma_oe4, sigma_oe5, sigma_oeLT1, sigma_oeLT2, gammap, vrbs_obs);

    % Options

    % N = 500; % number of particles
    % gam_eff = 0.75; % threshold for resampling (number from Creal 2009 survey: discusses range between .5 and .75)
    %                 % set greater than 1 for resampling in every period

    % Shocks
    % Shock = randn(N,size(Y_dataB,2)+1); % standardized shocks
    %
    % Resample_random = rand(size(Y_dataB,2),1); % random draws for the resampling algorithm
    %
    % gain_rand_ini = repmat(1/paramB.ini_g,1,N)'; % or drawn from a uniform distribution;
    %
    % Random_ini = randn(N,1);

    % Order:

    % pibart = 1; kt = 2;
    %
    % zt = 1; st = 1; pit = 3;

    % xitt_vec = NaN(3,N);
    %
    % ktt_vec = NaN(N);
    %
    % pitt_vec = NaN(N);

    % xipt_vec = NaN(3,N);
    %
    % kpt_vec = NaN(N);
    %
    % pipt_vec = NaN(N);

    % Model

    Scmp = [sigma_eps sigma_u
        sigma_eps 0
        sigma_eps sigma_u];

    Qmp = Scmp * Scmp';

    % 1. Initialize

    gmin = 0.01;

    %kpt_vec = gmin + (g-gmin).*gain_rand_ini;
    kpt_vec = 1 ./ (gmin + (g - gmin) .* gain_rand_ini);

    % VCVini = (1/10)*eye(3);

    P0p = VCVini;

    pi0_vec = sqrt(VCVini(1, 1)) * Random_ini;

    pipt_vec = pi0_vec;

    xipt_vec = zeros(3, N);

    qqrL = (1 / N) * ones(N, 1); % initial importance weights (t-1)

    % Lik

    Lik = 0;

    for jT = 1:sampleSize

        isobs = find(~isnan(Y_data(:, jT)));

        % 2. Compute PF measurement equation

        OMt = H(:, isobs)' * P0p * H(:, isobs) + R(isobs, isobs);

        %OMt = 0.5*(OMt + OMt');

        detOMt = det(OMt);

        %SING = (abs(detOMt) < 10^-5);
        SING = (abs(detOMt) < 10^-9);

        if (SING)
            % Lik = -10e20; flag = 1; disp('damn!');disp(abs(detOMt)); return
            Lik = -10e20; flag = 1; return

        else

            inv_OMt = OMt \ eye(size(OMt));

        end

        % Importance weights

        Pred = repmat(Y_data(isobs, jT), 1, N) - repmat(mu(isobs), 1, N) - ...
            Hpi(isobs) * pipt_vec' - H(:, isobs)' * xipt_vec;

        qq = qqrL .* (detOMt^ - (1/2) * exp(- (1/2) * diag(Pred' * inv_OMt * Pred)));

        % qq = Makeqq_mex(qqrL,detOMt,inv_OMt,Pred);

        % normalize particles

        qqr = qq ./ sum(qq);

        if isnan(qqr)
            Lik = -10e20; flag = 1; return
        end

        % Compute effective sample size

        Neff = 1 / (sum(qqr.^2));
        %toc

        if (Neff < gam_eff * N)

            %% 3. Resampling

            indx = resample(qqr, Resample_random(jT));

            % Duplicate particles

            pitt_vec = pipt_vec(indx);

            ktt_vec = kpt_vec(indx);

            % Reallocate particles in the xit prediction vector
            xipt_vec = xipt_vec(:, indx);

            qqr = ones(N, 1) ./ N; % normalize. Keep in mind now
            % the weights are the same as the particles have been duplicated
            % proportionally

        else

            pitt_vec = pipt_vec;

            ktt_vec = kpt_vec;

        end

        % 4. Linear measurement equation

        Kg = P0p * H(:, isobs) * inv_OMt;

        Pred2 = repmat(Y_data(isobs, jT), 1, N) - repmat(mu(isobs), 1, N) - ...
            Hpi(isobs) * pitt_vec' - H(:, isobs)' * xipt_vec;

        xitt_vec = xipt_vec + Kg * Pred2;

        P0 = P0p - Kg * H(:, isobs)' * P0p;

        % 5. Particle filter prediction

        % a. Gain

        E_rr = abs((1 - gammap) * (Tpi - 1) * pitt_vec ./ STDfeM);

        sw = (E_rr <= nu);
        %sw = (E_rr < 0);

        kpt_vec = (ktt_vec + 1) .* sw + (1 / g) .* (1 - sw);

        % b. Predict pibar

        f_pibar = (1 - (1 - gammap) * (1 - Tpi) * kpt_vec.^-1) .* pitt_vec;

        pipt_vec = f_pibar + kpt_vec.^-1 .* xitt_vec(1, :)' + ...
            kpt_vec.^-1 .* sqrt(P0(1, 1)) .* Shock(:, jT);

        % 6. Linear model prediction

        xipt_vec(1, :) = zeros(N, 1); % zt is i.id. with mean zero

        xipt_vec(2, :) = rho_phi * xitt_vec(2, :)' + ((P0(1, 2) / P0(1, 1)) * rho_phi) * kpt_vec .* ...
            (pipt_vec - f_pibar - kpt_vec.^-1 .* xitt_vec(1, :)'); % st is AR(1)

        xipt_vec(3, :) = (1 - gammap) * Tpi * f_pibar + (1 - gammap) * Tpi * kpt_vec.^-1 .* xitt_vec(1, :)' + ...
            rho_phi * xitt_vec(2, :)' + gammap * xitt_vec(3, :)' + ...
            kpt_vec .* ((P0(1, 2) / P0(1, 1)) * rho_phi + (P0(1, 3) / P0(1, 1)) * gammap + kpt_vec.^-1 * (1 - gammap) * Tpi) .* ...
            (pipt_vec - f_pibar - kpt_vec.^-1 .* xitt_vec(1, :)');

        iota1 = (P0(2, 2) - P0(1, 2)^2 / P0(1, 1)) * rho_phi^2;

        iota2 = (-P0(1, 2) * P0(1, 3) / P0(1, 1) + P0(2, 3)) * rho_phi * gammap;

        iota3 = (P0(3, 3) - P0(1, 3)^2 / P0(1, 1)) * gammap^2;

        P0_til = [0 0 0
            0 iota1 iota1 + iota2
            0 iota1 + iota2 2 * iota2 + iota1 + iota3];

        P0p = P0_til + Qmp;

        if jT > trainingSampleLength

            % Likelihood

            Lik = Lik + log(sum(qq));
            % disp([num2str(Lik),'   ','iteration n.','   ',num2str(jT)])
            %    if jT > 77
            %        keyboard
            %    end
        end

        qqrL = qqr; % updates lagges weights

    end
