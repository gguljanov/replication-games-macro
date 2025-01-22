# A Replication of Anchored Inflation Expectations

## About

This repository contains the replication files of the replication study "A Replication of Anchored Inflation Expectations" from 2024 by Boris Blagov, Gaygysyz Guljanov, and Aicha Kharazi. This replication study checks the robustness of the paper Carvalho, Eusepi, Moench, and Preston (2023)[^1] and is available here: https://econpapers.repec.org/paper/zbwi4rdps/174.htm

[^1]: Carvalho, C., Eusepi, S., Moench, E. and Preston, B.: 2023, Anchored inflation expectations, American Economic Journal: Macroeconomics 15(1), 1–47.

Reproducibility is checked in two dimensions:

1. "Matlab_code" folder: checks the strength of the empirical results by extending the data that was used in the original paper
2. "slice-sampler" folder: checks the robustness to changing the estimation methodology. It replaces Random-Walk-Metropolis-Hastings (RWMH) algorithm with slice sampler.

This repository consists of some files

1. from replication codes of the original study paper
2. from DYNARE source codes,
3. by the Boris Blagov, Gaygysyz Guljanov, and Aicha Kharazi

# Robustness check 1: Extending data

## How to run

# Robustness check 2: Using Slice sampler

## How to run

**run_estim**: Runs the estimations

-   Common functions folder contains all the functions used in the replication process

-   `prior()` function gives the log-prior at the parameter values

-   `mpf()`:

    -   We used original codes
    -   We cite the paper here
    -   we took $G^n_t$ and $G^l_t$ matrices as identity matrices
    -   We assume that measurement errors and state shocks are uncorrelated
