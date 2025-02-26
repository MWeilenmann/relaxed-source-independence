function B=generalized_3CHSH
%generates the Bell functional (in notation B(x,b,z)) for the conditioned
%3CHSH inequality \mathcal{B}_b

%first, generate all correlators

for x=1:3
    for z=1:6
        E{x,z}=(2*ket(x+1,4)-ket(1,4))*(2*bra(z+1,7)-bra(1,7));
    end
end

%next, generate 3CHSHs
B=zeros(4,4,7);
for b=1:4
    %extract two bits from b
    b1=cifra(b-1,1,2);
    b2=cifra(b-1,2,2);
    B(:,b,:)=(-1)^b2*E{1,1}+(-1)^b2*E{1,2}+(-1)^(b1)*E{2,1}-(-1)^(b1)*E{2,2}+...
        (-1)^b2*E{1,3}+(-1)^b2*E{1,4}-(-1)^(b1+b2)*E{3,3}+(-1)^(b1+b2)*E{3,4}+...
        (-1)^(b1)*E{2,5}+(-1)^(b1)*E{2,6}-(-1)^(b1+b2)*E{3,5}+(-1)^(b1+b2)*E{3,6};
    
    
end


end