# A Replication of Anchored Inflation Expectations

## About

This repository contains the replication files for the replication study "A Replication of Anchored Inflation Expectations" from 2024 by Boris Blagov, Gaygysyz Guljanov, and Aicha Kharazi (referred to as the replication study from now on). It is available here: https://econpapers.repec.org/paper/zbwi4rdps/174.htm

The replication study checks the robustness of the paper 'Carvalho, Carlos, Stefano Eusepi, Emanuel Moench, and Bruce Preston. 2023. "Anchored Inflation Expectations." American Economic Journal: Macroeconomics, 15 (1): 1–47.' (referred to as the original study from now on).

Reproducibility is checked in two dimensions:

1. The strength of the empirical results by extending the data that was used in the original paper
    - The related codes are in `Matlab_code` folder
2. The robustness to changing the estimation methodology. It replaces Random-Walk-Metropolis-Hastings (RWMH) algorithm with slice sampler.
    - The related codes are in `slice-sampler` folder

This repository consists of codes from the following sources

1. Carvalho, Carlos , Eusepi, Stefano, Moench, Emanuel, and Preston, Bruce. Data and Code for: “Anchored Inflation Expectations.” Nashville, TN: American Economic Association [publisher], 2023. Ann Arbor, MI: Inter-university Consortium for Political and Social Research [distributor], 2023-01-23. https://doi.org/10.3886/E147021V1
    - Licensed under a Creative Commons Attribution 4.0 International (CC BY 4.0) License. (https://creativecommons.org/licenses/by/4.0/);
    - referred to as original replication files
2. DYNARE source codes
    - Licensed under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version
3. New codes by the Boris Blagov, Gaygysyz Guljanov, and Aicha Kharazi
    - Licensed under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

# Robustness check 1: Extending data

## How to run

# Robustness check 2: Using Slice sampler

This check is implemented via object-oriented programming. `PartNonLinearModel()` is the base class and in a separate folder with its methods. The folder "common_functions`` contains all the other functions for the replication process.

The results will be saved in the folder `slice-sampler/Estim_res`, unless specified otherwise by the user.

For this robustness check, we use the US data from the original study. Therefore, make sure to use the `Make_USData.m` from the original replication files to build the data set `US_Data.mat`. This data set should then be copied or saved into the `slice-sampler` folder.

## How to run

##### `run_estim()`: Runs the entire estimation

-   Adds necessary folders to the path
-   Loads and prepares the data to be used for estimation
-   Makes an object of the class `PartNonLinearModel()`
-   Runs the `estim()` method

##### The .mat file `RandomStuff2500.mat`: From the original replication files

##### The folder `@PartNonLinearModel`: Contains the class and methods

##### The folder `common_functions`

-   The folder `liki_eval`: Functions for likelihood evaluation
-   The folder `prior_eval`: Functions for evaluation of joint prior
