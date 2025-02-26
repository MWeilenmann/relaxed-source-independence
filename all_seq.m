function list_seq=all_seq(n, num_settings)
%generates a vector with all operator monomials of length n or lower of the
%projector variables E_1,...,E_num_settings

list_seq1 = [Seq.id];
for setting=1:num_settings
    list_seq1=[list_seq1, Seq.meas(setting)];
end


if n==1
   list_seq=list_seq1;
else
    list_minus_1=all_seq(n-1, num_settings);
    list_seq =[];
    for ope1=list_seq1
        for ope2=list_minus_1
            ope12=ope1*ope2;
            list_seq=[list_seq, ope12];
            
        end
    end
    %remove duplicate operators
    list_seq=remove_duplicates(list_seq);
    
    
end

end