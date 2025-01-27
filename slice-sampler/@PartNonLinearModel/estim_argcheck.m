function returncode = estim_argcheck(obj)
% Checks the properties of obj, helpful for estimation
% -------------------------------------------------------------------------
% INPUTS
% - mu            [p by 1]   1st parameter of the CSN distribution (location)
% - cdfmvna_fct   [string]   name of function
% -------------------------------------------------------------------------
% OUTPUTS
% - E_csn         [p by 1]   expectation vector 
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

    % Folderpath and filename should be given
    if isempty(obj.estim_opts.folderpath)
        error("Provide folderpath")
    end

    
    if isempty(obj.estim_opts.filename)
        error("Provide filename")
    end

    
    % Up to now no errors encountered, so everything is okay
    returncode = 0;
end