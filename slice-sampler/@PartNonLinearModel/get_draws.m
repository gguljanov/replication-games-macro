function draws = get_draws(obj)
% Discards the burn-in phase from MCMC chain
% -------------------------------------------------------------------------
% INPUTS
% - obj: PartNonLinearModel
% -------------------------------------------------------------------------
% OUTPUTS
% - draws: MCMC draws with burn-in phase discarded
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

    draws = obj.draws(:, round(obj.bnin*size(obj.draws, 2)) : end);
end