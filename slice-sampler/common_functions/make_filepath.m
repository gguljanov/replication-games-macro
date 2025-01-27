function filepath = make_filepath(folderpath, filename)
% Makes filepath out of folderpath and filename
% Makes folder separating characters "/" for linux and "\" for windows
% -------------------------------------------------------------------------
% INPUTS
% - folderpath: Path to the folder containing the file
% - filename: Name of the file
% -------------------------------------------------------------------------
% OUTPUTS
% - filepath: Complete path to the file
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

    [folderpath, folder_sep] = correct_path(folderpath);

    % Make the filepath
    if strcmp(folderpath(end), folder_sep)
        filepath = sprintf("%s%s", folderpath, filename);
    else
        filepath = sprintf("%s%s%s", folderpath, folder_sep, filename);
    end
end





