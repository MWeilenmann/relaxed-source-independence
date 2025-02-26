function B=remove_duplicates(A)
%given a vector of class instances, it returns another vector with the
%duplicates removed

B =remove_dup_pos(1, A);


end


function B=remove_single(ele, A)
%removes all occurrences of element ele in A
B = [];
for k =1:length(A)
    if not(ele==A(k))
        B = [B,A(k)];
    end
end

end

function B=remove_dup_pos(pos, A)
%removes all duplicates of A from position pos downwards
if pos >= length(A)
    B=A;
else
    %removes duplicates of element in position pos and call the function
    %again
    newA = [A(1:pos), remove_single(A(pos), A(pos+1:length(A)))];
    B = remove_dup_pos(pos+1, newA);
end

end
