function igampdf = invgampdf(x, alpha, beta)
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

    invgampdf_scalar = @(scalar) beta^alpha / gamma(alpha) * scalar^(-alpha - 1) * exp(-beta / scalar);

    igampdf = arrayfun(invgampdf_scalar, x);
end
