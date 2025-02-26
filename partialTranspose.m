function rhoT = partialTranspose(rho, indices, dims)
%number of systems
n = length(dims);

rhoT = sparse(prod(dims), prod(dims));

dimsT=dims(indices);
for num1=1:prod(dimsT)
    v1 = allNumbers(num1, dimsT);
    for num2 = 1:prod(dimsT)
        v2 = allNumbers(num2, dimsT);
        ope = 1;
        for k=1:n
            if ismember(k,indices)
               [aux, pos] = ismember(k,indices);
               ope = tensor(ope, ket(v1(pos), dims(k))*bra(v2(pos), dims(k)));
            else
                ope = tensor(ope, eye(dims(k)));
            end
        end
        rhoT = rhoT + ope*rho*ope;
    end
        
    
    
end

end
