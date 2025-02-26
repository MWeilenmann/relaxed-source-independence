function C_mom=gen_const_moment(nA, nC)
%generates a matrix C_mom such that reshape(x*C_mom,mA*mC,mA*mC) is a
%moment matrix, with mA, mC respectively being the number of monomials of 
%degree mA and mC of the algebras with generators E_1,...,E_3 and
%E_1,...,E_6


%first, generate lists with all momenta from Alice and Bob
list_A=all_seq(2*nA, 3);
L_A=length(list_A);
list_C=all_seq(2*nC, 6);
L_C=length(list_C);

%size of each system in the moment matrix
mA=length(all_seq(nA, 3));
mC=length(all_seq(nC, 6));

%matrix of constraints
C_mom=sparse(L_A*L_C,(mA*mC)^2);
disp("Computing moment matrix constraints for nA="+num2str(nA)+", nC="+num2str(nC)+".");
for kC=1:L_C
    disp("Rows of Charlie's completed: "+num2str(kC-1)+"/"+num2str(L_C)+".");
    tic;
    %Charlie's N matrix for operator opeC
    opeC=list_C(kC);
    mat_C=gen_mat(opeC,nC,6);
        
    for kA=1:L_A
        %Alice's M matrix for operator opeA
        opeA=list_A(kA);
        mat_A=gen_mat(opeA,nA,3);       
        %total contribution to moment matrix (note symmetrization)
        mato=reshape((tensor(mat_A,mat_C)+tensor(mat_A,mat_C)')/2,1,(mA*mC)^2);
        C_mom=C_mom+tensor(ket(kA,L_A),ket(kC,L_C))*mato;
        
    end
    clc;
    duration=toc*(L_C-kC);
    disp("Computing moment matrix constraints for nA="+num2str(nA)+", nC="+num2str(nC)+".");
    disp("Estimated time to finish: "+num2str(duration)+" seconds.");
    
end
%we eliminate repeated rows. Those exist because we did a symmetrization
%step
C_mom=unique(C_mom,'rows');
clc;
disp("Task complete.");
C_mom   

end