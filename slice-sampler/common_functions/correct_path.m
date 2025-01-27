function [new_path, folder_sep] = correct_path(old_path)
% Makes folder separating characters "/" for linux and "\" for windows
% Correct the path using above folder separating characters
% -------------------------------------------------------------------------
% INPUTS
% - old_path: Path to be corrected
% -------------------------------------------------------------------------
% OUTPUTS
% - new_path: Corrected path
% - folder_sep: 
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

    % Folder separating character based on the OS being used
    if ismac || isunix % If mac or linux
        folder_sep = "/";
    elseif ispc % If windows
        folder_sep = "\";
    else
        error('Platform not supported');
    end
    
    new_path = convertStringsToChars(old_path);

    len = length(new_path);
    
    % Change the folder separating character to the "folder_sep"
    for ii = 1:len
        if strcmp(new_path(ii), '/') || strcmp(new_path(ii), '\')
            new_path(ii) = folder_sep;
        end
    end
end