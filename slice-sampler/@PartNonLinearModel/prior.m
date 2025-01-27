function [prr, prr_vec] = prior(obj, prop2)
% Log-prior distributions for the parameters
% -------------------------------------------------------------------------
% INPUTS
% - obj: PartNonLinearModel object
% - prop2: Proposed candidate at which prior density should be 
% evaluated, a column vector of dimension
% -------------------------------------------------------------------------
% OUTPUTS
% - prr: Joint prior density calculated at the proposed candidate 
% - prr_vec: A vector with prior values for each parameter
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

    prop = nan(length(obj.var_para), 1);
    prop(obj.var_para) = prop2;

    % Which parameter has which prior distribution
    prrdist = obj.prrdist;

    % Vector containing prior density values
    prr_vec = nan(length(obj.var_para), 1);
    

    % Prior from beta pdf
    mu_beta = obj.prrMn(prrdist.beta_param)';
    sigma2_beta = obj.prrVr(prrdist.beta_param)';
    
    a = (1 - mu_beta) .* mu_beta .* mu_beta ./ sigma2_beta - mu_beta;
    b = a .* (1./mu_beta - 1);

    prr_vec(prrdist.beta_param) = log( ...
        betapdf(prop(prrdist.beta_param), a', b') ...
    );


    %Prior from gamma pdf
    para1 = obj.prrMn(prrdist.gamma_param)';
    para2 = obj.prrVr(prrdist.gamma_param)';

    b = para2 ./ para1;
    a = para1 ./ b;

    prr_vec(prrdist.gamma_param) = log(gampdf(prop(prrdist.gamma_param), a', b'));
    

    % Prior from normal pdf
    prr_vec(prrdist.normal_param) = log(normpdf(prop(prrdist.normal_param), ...
                                        obj.prrMn(prrdist.normal_param), ...
                                        sqrt(obj.prrVr(prrdist.normal_param))));


    % Prior from inverted-Gamma-1
    for ii = prrdist.invgamma_param
        [alpha_, beta_] = solveInverseGamma(obj.prrMn(ii, 1), obj.prrVr(ii, 1));

        prr_vec(ii) = log(invgampdf(prop(ii), alpha_, beta_));
    end
    
    % Fixed parameters
    prr_vec(prrdist.fixed_param) = nan;


    % Evaluate the log-prior density
    prr_vec = prr_vec(obj.var_para);

    prr = sum(prr_vec);
end