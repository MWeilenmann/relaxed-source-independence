function dig=cifra(num,k,b)
%given a number, it returns its kth digit in base b

aux=num;

for j=1:k
    dig=mod(aux,b);
    
    aux=(aux-dig)/b;
end


end
