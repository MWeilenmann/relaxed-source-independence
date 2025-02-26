function M=gen_mat(seq, n, num_settings)
%given an operator monomial seq, it generates a matrix M, with rows and 
%columns labeled by the monomials of degree n or lower of a unital 
%*-algebra with projection generators E_1,...,E_{num_settings}, such that 
%M_{a,a'}=\delta_{a'a^\dagger, seq}

%generate a list of all operator monomials of degree n or lower
list_seq=all_seq(n, num_settings);
L= length(list_seq);
M= sparse(L,L);
for k1=1:L
    for k2=1:L
        ope1=list_seq(k1);
        ope2=list_seq(k2);
        if (seq==(ope1*adjoint(ope2)))
            M(k2,k1)=1;
        end
    end
end
            
            



end
