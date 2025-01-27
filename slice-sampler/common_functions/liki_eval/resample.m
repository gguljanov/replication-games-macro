function indx = resample(w, rd_number)
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

    N = length(w);
    Q = cumsum(w);
    indx = NaN(N, 1);
    
    T = linspace(0, 1 - 1 / N, N) + rd_number / N;
    
    % T = linspace(0, 1 - 1 / N, N) + rand(1) / N;
    
    T(N + 1) = 1;
    
    ii = 1;
    jj = 1;
    
    while ii <= N
        if T(ii) < Q(jj)
            indx(ii) = jj;

            ii = ii + 1;
        else
            jj = jj + 1;
        end
    end
end