function sol=optim_relaxed(Bell, nA, nC, const_mom, const_PPT, epsilon)
% this function maximizes the violation of a tripartite Bell inequality, 
% under the assumption that the second party has just one measurement setting, 
% and that the three parties are arranged in the bilocal network with real
% states and measurements and where the states are partially independent as
% quantigfied by epsilon


% we assume that Alice (Charlie) has three (six) dichotomic measurements.
% Bob has a four-outcome measurement b=1,2,3,4.
list_A=all_seq(nA, 3);
list_C=all_seq(nC, 6);
mA=length(list_A);
mC=length(list_C);

% number of variables in each moment matrix, where const_mom is a matrix such 
% that reshape(x*const_mom,mA*mC,mA*mC) is in the span of moment matrices of 
% size m_A\times m_C
L=size(const_mom,1);

% build moment matrices:
% moment matrices for the four outcomes (corresponding to the moment matrices 
% for the \tau^b)
for b=1:4
    mom{b}=sdpvar(1,L);
    G{b}=reshape(mom{b}*const_mom, mA*mC,mA*mC);    
end
% moment matrix for \sigma (which will satisfy the self-PT constraint)
    mom2=sdpvar(1,L);
    G2=reshape(mom2*const_mom, mA*mC,mA*mC);    
% moment matrix for M
    momM=sdpvar(1,L);
    GM=reshape(momM*const_mom, mA*mC,mA*mC);    
% moment matrix for N
    momN=sdpvar(1,L);
    GN=reshape(momN*const_mom, mA*mC,mA*mC);    

% positivity and normalization (for \sum_b \tau^b and \sigma)
const =[];
% find position of identity operator in A and C lists
id_a= find_operator(Seq.id, list_A);
id_c= find_operator(Seq.id, list_C);
% for moment matrices of \tau^b
norma=0;
v_id=tensor(ket(id_a,mA),ket(id_c,mC));
for b=1:4
    const=const+[G{b}>=0];
    norma= norma+v_id'*G{b}*v_id;    
end
const = const+[norma==1];
% for moment matrix of \sigma
const=const+[G2>=0];
norma2= v_id'*G2*v_id;
const = const+[norma2==1];

% impose self-PT constraint (for the moment matrix of \sigma)
const = const+[mom2*const_PPT==0]; 

% sum the momenta for the different b-values
mom_tot=sparse(1,L);
for b=1:4
    mom_tot=mom_tot+mom{b};
end

% create the total moment matrix for the trace distance constraint and impose 
% the corresponding positivity constraint
G1tot=reshape(mom_tot*const_mom, mA*mC,mA*mC);

Gtot = [GM, (G1tot-G2); transpose(G1tot-G2), GN];
const = const+ [Gtot >= 0];

% impose the corresponding bound on the trace of M and N in terms of
% epsilon
normM= v_id'*GM*v_id;
normN= v_id'*GN*v_id;

const = const+ [normM + normN <= 4*epsilon]


% create objective function
% notation of Bell functional: B(x+1, b, z+1) is the coefficient that goes
% with operator E_{0|x}G_{b}F_{0|z}. E_{0|0}=F_{0|0}=1.
obj=0;
for b=1:4
    for xm=0:3
        for zm=0:6
            % find the positions of Alice and Bob's measurement operators
            if xm==0
                k_a=id_a;
            else
                k_a = find_operator(Seq.meas(xm),list_A);
            end
            if zm==0
                k_c=id_c;
            else
                k_c = find_operator(Seq.meas(zm),list_C);
            end
            % update the objective function
            obj = obj + (v_id'*G{b}*tensor(ket(k_a,mA),ket(k_c,mC)))*Bell(xm+1, b,zm+1);
            
        end
    end
end



% maximize objective function, specifying the solver
ops= sdpsettings('solver', 'scs'); %'mosek'
optimize(const, -obj, ops);
sol=double(obj);

end


