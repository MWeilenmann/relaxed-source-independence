# Partial independence suffices to prove real Hilbert spaces insufficient in quantum physics
This repository provides the MATLAB codes accompanying our manuscript ``Partial independence suffices to prove real Hilbert spaces insufficient in quantum physics''. 

They extend the codes from https://www.nature.com/articles/s41586-021-04160-4 to allow relaxing the source independence assumption. The changes are in the files bound_relaxed_sources and optim_relaxed. The remaining files are taken over from https://www.nature.com/articles/s41586-021-04160-4.

To run the codes, the MATLAB package YALMIP (https://yalmip.github.io/) and an SDP solver such as Mosek (https://www.mosek.com/) or SCS (https://github.com/cvxgrp/scs) is required.

With SCS the codes run on a desktop computer, with Mosek they require computing facilities with additional memory (we used up to 500 GB RAM), however, providing more accurate results.
