function sol = bound_relaxed_sources
%solves an SDP to bound the maximum value of the Bell functional \mathcal{B}
%under real quantum physics and outputs the final result

addpath(genpath('YALMIP-master'))
addpath(genpath('soft'))

%hierarchy levels (i.e., monomial degrees)
nA=2;
nC=2;

%create general moment matrix constraints
C_mom=gen_const_moment(nA, nC);

%create self-PT constraints 
C_PPT=gen_PPT_const(C_mom,nA,nC);

%set an upper bound on the trace distance to the set of separable states
epsilon = 0.4

%impose actual constraints and solve the SDP
sol=optim_relaxed(generalized_3CHSH, nA, nC, C_mom, C_PPT, epsilon)

%display the result
disp("Distributions $P$ admitting a real quantum representation with source independence bounded by $"+num2str(epsilon)+"$ satisfy $\mathcal{B}(P)\leq "+num2str(sol)+"$.");


end